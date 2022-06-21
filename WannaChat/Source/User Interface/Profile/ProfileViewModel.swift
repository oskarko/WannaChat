//  ProfileViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

class ProfileViewModel {
    
    // MARK: - Properties
    
    weak var view: ProfileViewControllerProtocol?
    var router: ProfileRouter?
    private var user: User!
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
    }
    
    // MARK: - Helpers
    
    func getUser() -> User {
        user
    }
    
    func getIdentifier(for indexPath: IndexPath) -> String? {
        guard let sectionType = ProfileSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header: return ProfileHeaderType(rawValue: indexPath.row)?.identifier
        case .text: return ProfileTextType(rawValue: indexPath.row)?.identifier
        }
    }
    
    func getCellTitle(for indexPath: IndexPath) -> String? {
        guard let sectionType = ProfileSectionType(rawValue: indexPath.section) else { return nil }
        
        switch sectionType {
        case .header: return ProfileHeaderType(rawValue: indexPath.row)?.titleString
        case .text: return ProfileTextType(rawValue: indexPath.row)?.titleString
        }
    }
    
    func numberOfSections() -> Int {
        ProfileSectionType.allCases.count
    }
    
    func heightForHeader(at section: Int) -> Int {
        section == 0 ? 0 : 20
    }
    
    func numberOfRows(at section: Int) -> Int {
        guard let sectionType = ProfileSectionType(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .header: return ProfileHeaderType.allCases.count
        case .text: return ProfileTextType.allCases.count
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> Int {
        guard let sectionType = ProfileSectionType(rawValue: indexPath.section) else { return 0 }
        
        switch sectionType {
        case .header: return ProfileHeaderType(rawValue: indexPath.row)?.height ?? 0
        case .text: return ProfileTextType(rawValue: indexPath.row)?.height ?? 0
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let sectionType = ProfileSectionType(rawValue: indexPath.section) else { return }
        
        switch sectionType {
        case .header: break
        case .text: startChat()
        }
    }
    
    private func startChat() {
        if let currentUser = User.currentUser {
            let chatId = WannaChat.startChat(user1: currentUser, user2: user)
            
            router?.showNewChatView(chatRoomId: chatId,
                                    recipientId: user.id,
                                    recipientName: user.username)
        }
    }
}
