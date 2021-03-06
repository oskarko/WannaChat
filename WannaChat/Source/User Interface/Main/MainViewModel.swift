//  MainViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class MainViewModel {
    
    // MARK: - Properties
    
    weak var view: MainViewControllerProtocol?
    var router: MainRouter?
    
    // MARK: - Helpers
    
    func viewDidAppear() {
        view?.setupView()
    }
}
