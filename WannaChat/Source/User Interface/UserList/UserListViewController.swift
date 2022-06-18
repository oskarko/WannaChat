//  UserListViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol UserListViewControllerProtocol: AnyObject {
    func reloadData()
}

class UserListViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: UserListViewModel!
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Uncomment the first time just to create some dummy users!
        //createDummyUsers()
        
        configureNavigationBar(withTitle: "Users", prefersLargeTitles: true)
        configureSearchController()
        configureTableView()
        configureUI()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Selectors
    
    @objc func tableViewRefreshed() {
        viewModel.tableViewRefreshed()
    }

    // MARK: - Helpers
    
    private func configureSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search user"
        searchController.searchResultsUpdater = viewModel
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        tableView.register(SettingsHeaderCell.nib, forCellReuseIdentifier: SettingsHeaderCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.refreshControl = refreshControl
        
        refreshControl.tintColor = .darkGray
        refreshControl.addTarget(self, action: #selector(tableViewRefreshed), for: .valueChanged)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    private func configureUI() { }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: tableView.frame.width, height: 10)))
        view.backgroundColor = .tableViewBackgroundColor

        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsHeaderCell.identifier,
                for: indexPath
            ) as? SettingsHeaderCell
        else {
            assertionFailure("Could not deque cell")
            return UITableViewCell()
        }

        cell.configure(with: viewModel.getUser(at: indexPath))
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - UserListViewControllerProtocol

extension UserListViewController: UserListViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
}
