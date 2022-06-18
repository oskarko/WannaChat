//
//  FirebaseRecentChatListener.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

class FirebaseRecentChatListener {
    
    static let shared = FirebaseRecentChatListener()
    
    private init() { }
    
    // MARK: - Add recent chats
    
    func addRecentChat(_ recent: RecentChat) {
        do {
            try firebaseReference(.recent).document(recent.id).setData(from: recent)
        } catch {
            print("Error saving recent chat: ", error.localizedDescription)
        }
        
    }
}
