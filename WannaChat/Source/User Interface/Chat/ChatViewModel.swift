//  ChatViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    // MARK: - Properties
    
    weak var view: ChatViewControllerProtocol?
    var router: ChatRouter?
    
    private var chatRoomId: String
    private var recipientId: String
    private var recipientName: String
    
    // MARK: - Lifecycle
    
    init(chatRoomId: String, recipientId: String, recipientName: String) {
        self.chatRoomId = chatRoomId
        self.recipientId = recipientId
        self.recipientName = recipientName
    }
    
    // MARK: - Helpers
    
}
