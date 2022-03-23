//  UserListRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class UserListRouter {
    
    // MARK: - Properties
    
    weak var viewController: UserListViewController?

    // MARK: - Helpers
    
    static func getViewController() -> UINavigationController {
        let configuration = configureModule()

        //return configuration.vc
        let nav = UINavigationController(rootViewController: configuration.vc)

        return nav
    }
    
    private static func configureModule() -> (vc: UserListViewController, vm: UserListViewModel, rt: UserListRouter) {
        let viewController = UserListViewController()
        let router = UserListRouter()
        let viewModel = UserListViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
