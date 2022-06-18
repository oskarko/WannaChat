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
    func deleteRows(at indexPaths: [IndexPath])
    func show(message: String, type: MessageType)
}

class ChatListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: ChatListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        configureSearchController()
        configureTableView()
        configureUI()
        viewModel.viewDidLoad()
    }
    

    // MARK: - Selectors

    @objc func newChatButtonTapped() {
        viewModel.newChatButtonTapped()
    }
    
    // MARK: - Helpers
    
    fileprivate func setupNavigationController() {
        configureNavigationBar(withTitle: "Chats", prefersLargeTitles: true)
        navigationItem.rightBarButtonItems = [
            .newChatButton(self, #selector(newChatButtonTapped)),
        ]
    }
    
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
    
    func deleteRows(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
    
    func show(message: String, type: MessageType) {
        DispatchQueue.main.async {
            print("Show Message: ", message)
            print("Show Message Type: ", type)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ChatListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: tableView.frame.width, height: 10)))
        view.backgroundColor = .tableViewBackgroundColor

        return view
    }
    
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteChat(at: indexPath)
        }
    }
    
}
