//  ChatListViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol ChatListViewControllerProtocol: AnyObject {
    func reloadData()
}

class ChatListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ChatListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(withTitle: "Chats", prefersLargeTitles: true)
        configureSearchController()
        configureTableView()
        configureUI()
        viewModel.viewDidLoad()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search chat"
        searchController.searchResultsUpdater = viewModel
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView.register(ChatCell.nib, forCellReuseIdentifier: ChatCell.identifier)
        tableView.tableFooterView = UIView()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }


    private func configureUI() {

    }
    
}

// MARK: - ChatListViewControllerProtocol

extension ChatListViewController: ChatListViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatCell.identifier,
                for: indexPath
            ) as? ChatCell
        else {
            assertionFailure("Could not deque cell")
            return UITableViewCell()
        }

        cell.configure(with: viewModel.getRecentChat(at: indexPath))
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
    
}
