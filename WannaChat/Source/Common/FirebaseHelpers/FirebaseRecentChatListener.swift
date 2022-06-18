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
    
    // MARK: - Download all recent chats
    
    func downloadRecentChatsFromFirestore(completion: @escaping (_ allRecents: [RecentChat]) -> Void) {
        guard let currentUserId = User.currentId else {
            completion([])
            return
        }
        
        firebaseReference(.recent).whereField(kSENDERID, isEqualTo: currentUserId)
            .addSnapshotListener { querySnapshot, error in
            
                var recentChats: [RecentChat] = []
                
                guard let documents = querySnapshot?.documents else {
                    print("no documents for recent chats")
                    completion([])
                    return
                }
                
                let allRecents = documents.compactMap { queryDocumentSnapshot in
                    return try? queryDocumentSnapshot.data(as: RecentChat.self)
                }
                
                for recent in allRecents {
                    if !recent.lastMessage.isEmpty {
                        recentChats.append(recent)
                    }
                }
                
                recentChats.sort(by: { $0.date! > $1.date! })
                completion(recentChats)
        }
    }
    
    // MARK: - Delete RecentChat
    
    func deleteRecentChat(_ recentChat: RecentChat, completion: @escaping (Error?) -> Void) {
        firebaseReference(.recent).document(recentChat.id).delete { error in
            completion(error)
        }
    }
}
