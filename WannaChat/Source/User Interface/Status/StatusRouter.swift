//  StatusRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class StatusRouter {
    
    // MARK: - Properties
    
    weak var viewController: StatusViewController?

    // MARK: - Helpers
    
    static func getViewController() -> StatusViewController {
        let configuration = configureModule()

        return configuration.vc
    }
    
    private static func configureModule() -> (vc: StatusViewController, vm: StatusViewModel, rt: StatusRouter) {
        let viewController = StatusViewController()
        let router = StatusRouter()
        let viewModel = StatusViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}