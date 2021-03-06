//  SettingsRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class SettingsRouter {
    
    // MARK: - Properties
    
    weak var viewController: SettingsViewController?

    // MARK: - Helpers
    
    static func getViewController() -> UINavigationController {
        let configuration = configureModule()

        //return configuration.vc
        let nav = UINavigationController(rootViewController: configuration.vc)

        return nav
    }
    
    private static func configureModule() -> (vc: SettingsViewController, vm: SettingsViewModel, rt: SettingsRouter) {
        let viewController = SettingsViewController()
        let router = SettingsRouter()
        let viewModel = SettingsViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
    func showEditProfileView() {
        DispatchQueue.main.async { [weak self] in
            let editProfileView = EditProfileRouter.getViewController()
            self?.viewController?.navigationController?.pushViewController(editProfileView, animated: true)
        }
    }
    
    func showLoginView() {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.dismiss(animated: true) {
                UIApplication.rootViewController = AuthRouter.getViewController()
            }
        }
    }
    
}
