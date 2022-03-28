//  EditProfileViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import Gallery
import ProgressHUD

class EditProfileViewModel {
    
    // MARK: - Properties
    
    weak var view: EditProfileViewControllerProtocol?
    var router: EditProfileRouter?
    var gallery: GalleryController!
    
    // MARK: - Helpers
    
    func getIdentifier(for indexPath: IndexPath) -> String? {
        guard let sectionType = EditProfileSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header: return EditProfileHeaderType(rawValue: indexPath.row)?.identifier
        case .text: return EditProfileTextType(rawValue: indexPath.row)?.identifier
        }
    }
    
    func numberOfSections() -> Int {
        EditProfileSectionType.allCases.count
    }
    
    func heightForHeader(at section: Int) -> Int {
        section == 0 ? 0 : 35
    }
    
    func numberOfRows(at section: Int) -> Int {
        guard let sectionType = EditProfileSectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .header: return EditProfileHeaderType.allCases.count
        case .text: return EditProfileTextType.allCases.count
        }
    }
    
    func getCellTitle(for indexPath: IndexPath) -> String? {
        guard let sectionType = EditProfileSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header:
                guard
                    let header = EditProfileHeaderType(rawValue: indexPath.row), header == .textField
                else { return nil}
                
                return getUser()?.username
        case .text: return getUser()?.status ?? ""
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> Int {
        guard let sectionType = EditProfileSectionType(rawValue: indexPath.section) else { return 0 }
        
        switch sectionType {
        case .header: return EditProfileHeaderType(rawValue: indexPath.row)?.height ?? 0
        case .text: return EditProfileTextType(rawValue: indexPath.row)?.height ?? 0
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard
            let sectionType = EditProfileSectionType(rawValue: indexPath.section),
                sectionType == .text
        else { return }
        
        router?.showSelectStatusView()
    }
    
    func getUser() -> User? {
        User.currentUser
    }
    
    func usernameDidChange(_ username: String) {
        guard var user = User.currentUser else { return }
        
        user.username = username
        saveUserLocally(user)
        FirebaseUserListener.shared.saveUserToFireStore(user)
    }
}

// MARK: - GalleryControllerDelegate

extension EditProfileViewModel: GalleryControllerDelegate {
    
    func showImageGallery() {
        gallery = GalleryController()
        gallery.delegate = self
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 1
        Config.initialTab = .imageTab
        
        router?.present(gallery)
    }
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        guard let image = images.first else { return }
        
        image.resolve { [weak self] avatarImage in
            guard let self = self else { return }
            
            if let avatarImage = avatarImage {
                self.uploadAvatarImage(avatarImage)
            } else {
                ProgressHUD.showError("Could not select image!")
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Upload Images

private extension EditProfileViewModel {
    
    func uploadAvatarImage(_ avatarImage: UIImage) {
        guard let currentId = User.currentId else { return }
        
        let fileDirectory = "Avatars/_\(currentId).jpg"
        
        FileStorage.uploadImage(avatarImage, directory: fileDirectory) { [weak self] avatarLink in
            if var user = self?.getUser() {
                user.avatarLink = avatarLink ?? ""
                saveUserLocally(user)
                FirebaseUserListener.shared.saveUserToFireStore(user)
                
                // refresh UI
                let indexPath = IndexPath(row: EditProfileHeaderType.profile.rawValue,
                                          section: EditProfileSectionType.header.rawValue)
                self?.view?.refreshCells(at: [indexPath])
            }
            
            // Save file locally
            if let jpgData = avatarImage.jpegData(compressionQuality: 1.0) as NSData? {
                FileStorage.saveFileLocally(fileData: jpgData, fileName: currentId)
            }
        }
    }
}
