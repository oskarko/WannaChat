//  MainViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func setupView()
}

class MainViewController: UITabBarController {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemPurple

    }
    
}

// MARK: - MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    
    func setupView() {
        let controllers: [UIViewController] = []
        viewControllers = controllers
    }
}
