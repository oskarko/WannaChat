//  UserListViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol UserListViewControllerProtocol: AnyObject {

}

class UserListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: UserListViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {


    }
    
}

// MARK: - UserListViewControllerProtocol

extension UserListViewController: UserListViewControllerProtocol {

}
