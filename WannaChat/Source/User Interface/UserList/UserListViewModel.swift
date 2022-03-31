//  UserListViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

class UserListViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var view: UserListViewControllerProtocol?
    var router: UserListRouter?
    private var allUsers: [User] = []
    private var filteredUsers: [User] = []
    
    private var isSearchMode: Bool {
        !filteredUsers.isEmpty
    }
    
    // MARK: - Lifecycle
    
    override init() {
        super.init()
        
        downloadUsers {
            print("Downloading user on init")
        }
    }
    
    // MARK: - Helpers
    
    func numberOfRows() -> Int {
        isSearchMode ? filteredUsers.count : allUsers.count
    }
    
    func getUser(at indexPath: IndexPath) -> User? {
        isSearchMode ? filteredUsers[indexPath.row] : allUsers[indexPath.row]
    }
    
    func heightForRow(at indexPath: IndexPath) -> Int {
        SettingsHeaderType.profile.height
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if let user = getUser(at: indexPath) {
            router?.showProfileView(for: user)
        }
    }
    
    func tableViewRefreshed() {
        downloadUsers { [weak self] in
            self?.view?.reloadData()
        }
    }
}

private extension UserListViewModel {
    func downloadUsers(_ completion: @escaping () -> Void) {
        FirebaseUserListener.shared.downloadAllUsersFromFirebase { [weak self] users in
            guard let self = self else { return }
            
            self.allUsers = users
            completion()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension UserListViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filteredUsers = allUsers.filter({ $0.username.lowercased().contains(text.lowercased()) })
        } else {
            filteredUsers.removeAll()
        }
        
        view?.reloadData()
    }
}
