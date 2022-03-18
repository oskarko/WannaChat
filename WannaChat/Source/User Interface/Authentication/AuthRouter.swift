//  AuthRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class AuthRouter {
    
    // MARK: - Properties
    
    weak var viewController: AuthViewController?

    // MARK: - Helpers
    
    static func getViewController() -> AuthViewController {
        let configuration = configureModule()

        return configuration.vc
    }
    
    private static func configureModule() -> (vc: AuthViewController, vm: AuthViewModel, rt: AuthRouter) {
        let viewController = AuthViewController()
        let router = AuthRouter()
        let viewModel = AuthViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}