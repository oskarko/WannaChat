//  EditProfileRouter.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

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
    
    func present(_ view: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.present(view, animated: true)
        }
    }
    
    func showSelectStatusView() {
        DispatchQueue.main.async { [weak self] in
            let statusView = StatusRouter.getViewController()
            self?.viewController?.navigationController?.pushViewController(statusView, animated: true)
        }
    }
}
