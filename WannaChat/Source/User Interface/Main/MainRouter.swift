//  MainRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class MainRouter {
    
    // MARK: - Properties
    
    weak var viewController: MainViewController?

    // MARK: - Helpers
    
    static func getViewController() -> MainViewController {
        let configuration = configureModule()

        return configuration.vc
    }
    
    private static func configureModule() -> (vc: MainViewController, vm: MainViewModel, rt: MainRouter) {
        let viewController = MainViewController()
        let router = MainRouter()
        let viewModel = MainViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}