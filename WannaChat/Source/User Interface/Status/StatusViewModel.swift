//  StatusViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

class StatusViewModel {
    
    // MARK: - Properties
    
    weak var view: StatusViewControllerProtocol?
    var router: StatusRouter?
    
    // MARK: - Helpers
    
    func numberOfRows(at section: Int) -> Int {
        Status.allCases.count
    }
    
    func getStatus(for indexPath: IndexPath) -> String? {
        guard let status = Status(rawValue: indexPath.row) else { return nil }
        
        return status.stringValue
    }
    
    func isCurrentStatus(for indexPath: IndexPath) -> Bool {
        guard
            let status = Status(rawValue: indexPath.row),
            let user = getUser()
        else {
            return false
        }
        
        return user.status == status.stringValue
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard
            let status = Status(rawValue: indexPath.row),
            var user = getUser()
        else {
            return
        }
        
        user.status = status.stringValue
        saveUserLocally(user)
        FirebaseUserListener.shared.saveUserToFireStore(user)
        view?.reloadData()
    }
    
    private func getUser() -> User? {
        User.currentUser
    }
}
