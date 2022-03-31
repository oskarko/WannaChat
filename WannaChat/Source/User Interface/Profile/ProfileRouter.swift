//  ProfileRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

class ProfileRouter {
    
    // MARK: - Properties
    
    weak var viewController: ProfileViewController?

    // MARK: - Helpers
    
    static func getViewController(for user: User) -> ProfileViewController {
        let configuration = configureModule(for: user)

        return configuration.vc
    }
    
    private static func configureModule(for user: User) -> (vc: ProfileViewController, vm: ProfileViewModel, rt: ProfileRouter) {
        let viewController = ProfileViewController()
        let router = ProfileRouter()
        let viewModel = ProfileViewModel(user: user)

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
    func showNewChatView() {
        DispatchQueue.main.async { [weak self] in
//            let statusView = StatusRouter.getViewController()
//            self?.viewController?.navigationController?.pushViewController(statusView, animated: true)
        }
        print("Open Chat")
    }
}
