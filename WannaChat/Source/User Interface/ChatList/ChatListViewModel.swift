//  ChatListViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

class ChatListViewModel {
    
    // MARK: - Properties
    
    weak var view: ChatListViewControllerProtocol?
    var router: ChatListRouter?
    
    // MARK: - Helpers
    
    func numberOfRows(in section: Int) -> Int {
        0
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
}
