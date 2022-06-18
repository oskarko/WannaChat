//  ChatListViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

class ChatListViewModel: NSObject {
    
    // MARK: - Properties
    
    weak var view: ChatListViewControllerProtocol?
    var router: ChatListRouter?
    private var allRecents: [RecentChat] = []
    private var filteredRecents: [RecentChat] = []
    
    private var isSearchMode: Bool {
        !filteredRecents.isEmpty
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
        downloadRecentChats()
    }
    
    private func downloadRecentChats() {
        FirebaseRecentChatListener.shared.downloadRecentChatsFromFirestore { [weak self] allRecents in
            guard let self = self else { return }
            
            self.allRecents = allRecents
            self.view?.reloadData()
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        isSearchMode ? filteredRecents.count : allRecents.count
    }
    
    func getRecentChat(at indexPath: IndexPath) -> RecentChat {
        isSearchMode ? filteredRecents[indexPath.row] : allRecents[indexPath.row]
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let recentChat = isSearchMode ? filteredRecents[indexPath.row] : allRecents[indexPath.row]
        router?.showChatView()
    }
    
    func deleteChat(at indexPath: IndexPath) {
        let recentChat = isSearchMode ? filteredRecents[indexPath.row] : allRecents[indexPath.row]
        
        FirebaseRecentChatListener.shared.deleteRecentChat(recentChat) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.show(message: error.localizedDescription, type: .error)
            } else {
                _ = self.isSearchMode ?
                self.filteredRecents.remove(at: indexPath.row) :
                self.allRecents.remove(at: indexPath.row)
                
                self.view?.deleteRows(at: [indexPath])
            }
        }
    }
    
    func newChatButtonTapped() {
        router?.newChatButtonTapped()
    }
}

// MARK: - UISearchResultsUpdating

extension ChatListViewModel: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filteredRecents = allRecents.filter({ $0.receiverName.lowercased().contains(text.lowercased()) })
        } else {
            filteredRecents.removeAll()
        }
        
        view?.reloadData()
    }
}
