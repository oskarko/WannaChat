//  ChatRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class ChatRouter {
    
    // MARK: - Properties
    
    weak var viewController: ChatViewController?

    // MARK: - Helpers
    
    static func getViewController(chatRoomId: String,
                                  recipientId: String,
                                  recipientName: String) -> ChatViewController {
        let configuration = configureModule(chatRoomId: chatRoomId,
                                            recipientId: recipientId,
                                            recipientName: recipientName)

        return configuration.vc
    }
    
    private static func configureModule(chatRoomId: String,
                                        recipientId: String,
                                        recipientName: String) -> (vc: ChatViewController,
                                                                   vm: ChatViewModel,
                                                                   rt: ChatRouter) {
        let viewController = ChatViewController()
        let router = ChatRouter()
        let viewModel = ChatViewModel(chatRoomId: chatRoomId,
                                      recipientId: recipientId,
                                      recipientName: recipientName)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
