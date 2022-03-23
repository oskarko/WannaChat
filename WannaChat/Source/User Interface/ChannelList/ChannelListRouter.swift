//  ChannelListRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class ChannelListRouter {
    
    // MARK: - Properties
    
    weak var viewController: ChannelListViewController?

    // MARK: - Helpers
    
    static func getViewController() -> UINavigationController {
        let configuration = configureModule()

        //return configuration.vc
        let nav = UINavigationController(rootViewController: configuration.vc)

        return nav
    }
    
    private static func configureModule() -> (vc: ChannelListViewController, vm: ChannelListViewModel, rt: ChannelListRouter) {
        let viewController = ChannelListViewController()
        let router = ChannelListRouter()
        let viewModel = ChannelListViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
}
