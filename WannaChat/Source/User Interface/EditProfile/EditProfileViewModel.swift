//  EditProfileViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class EditProfileViewModel {
    
    // MARK: - Properties
    
    weak var view: EditProfileViewControllerProtocol?
    var router: EditProfileRouter?
    
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
        section == 0 ? 0 : 10
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
        case .header: return nil
        case .text: return nil
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
}
