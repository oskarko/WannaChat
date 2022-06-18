//
//  StartChat.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

func startChat(user1: User, user2: User) -> String {
    let chatRoomId = chatRoomIdFrom(user1Id: user1.id, user2Id: user2.id)
    createRecentItems(from: chatRoomId, users: [user1, user2])
    
    return chatRoomId
}

func chatRoomIdFrom(user1Id: String, user2Id: String) -> String {
    let value = user1Id.compare(user2Id).rawValue
    let chatRoomId = value < 0 ? (user1Id + user2Id) : (user2Id + user1Id)
    
    return chatRoomId
}

func createRecentItems(from chatRoomId: String, users: [User]) {
    
    var memberIdsToCreateRecent = [users.first!.id, users.last!.id]
    
    // does user have recent?
    firebaseReference(.recent).whereField(kCHATROOMID, isEqualTo: chatRoomId)
        .getDocuments { snapshot, error in
            
            guard
                let snapshot = snapshot,
                let currentId = User.currentId,
                let currentUser = User.currentUser
            else { return }
            
            if !snapshot.isEmpty {
                memberIdsToCreateRecent = removeMemberWhoHasRecent(snapshot: snapshot,
                                                                   memberIds: memberIdsToCreateRecent)
            }
            
            for userId in memberIdsToCreateRecent {
                let senderUser = userId == currentId ? currentUser : getReceiverFrom(users: users)
                let receiverUser = userId == currentId ? getReceiverFrom(users: users) : currentUser
                let recentObject = RecentChat(id: UUID().uuidString,
                                              chatRoomId: chatRoomId,
                                              senderId: senderUser.id,
                                              senderName: senderUser.username,
                                              receiverId: receiverUser.id,
                                              receiverName: receiverUser.username,
                                              date: Date(),
                                              memberIds: [senderUser.id, receiverUser.id],
                                              lastMessage: "",
                                              unreadCounter: 0,
                                              avatarLink: receiverUser.avatarLink)
                
                FirebaseRecentChatListener.shared.addRecentChat(recentObject)
            }
            
    }
}

func removeMemberWhoHasRecent(snapshot: QuerySnapshot, memberIds: [String]) -> [String] {
    var memberIdsToCreateRecent = memberIds
    
    for recentData in snapshot.documents {
        let currentRecent = recentData.data() as Dictionary
        
        if let currentUserId = currentRecent[kSENDERID] as? String,
           memberIdsToCreateRecent.contains(currentUserId),
           let index = memberIdsToCreateRecent.firstIndex(of: currentUserId) {
            memberIdsToCreateRecent.remove(at: index)
        }
    }
    
    return memberIdsToCreateRecent
}

func getReceiverFrom(users: [User]) -> User {
    var allUsers = users
    
    if let currentUser = User.currentUser,
       let index = allUsers.firstIndex(of: currentUser) {
        allUsers.remove(at: index)
    }
    
    return allUsers.first!
}
