//  ChannelListViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol ChannelListViewControllerProtocol: AnyObject {

}

class ChannelListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ChannelListViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .systemRed

    }
    
}

// MARK: - ChannelListViewControllerProtocol

extension ChannelListViewController: ChannelListViewControllerProtocol {

}
