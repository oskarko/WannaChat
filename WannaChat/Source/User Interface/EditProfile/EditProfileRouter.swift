//  EditProfileRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class EditProfileRouter {
    
    // MARK: - Properties
    
    weak var viewController: EditProfileViewController?

    // MARK: - Helpers
    
    static func getViewController() -> EditProfileViewController {
        let configuration = configureModule()

        return configuration.vc
    }
    
    private static func configureModule() -> (vc: EditProfileViewController, vm: EditProfileViewModel, rt: EditProfileRouter) {
        let viewController = EditProfileViewController()
        let router = EditProfileRouter()
        let viewModel = EditProfileViewModel()

        viewController.viewModel = viewModel

        viewModel.router = router
        viewModel.view = viewController

        router.viewController = viewController

        return (viewController, viewModel, router)
    }
    
    // MARK: - Routes
    
    func showSelectStatusView() {
        func showLoginView() {
            DispatchQueue.main.async { [weak self] in
                let editProfileView = EditProfileRouter.getViewController()
                self?.viewController?.navigationController?.pushViewController(editProfileView, animated: true)
            }
        }
    }
}
