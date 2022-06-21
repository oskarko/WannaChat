//  ProfileViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol ProfileViewControllerProtocol: AnyObject {

}

class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ProfileViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        configureTableView()
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers
    
    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.getUser().username
    }

    private func configureTableView() {
        tableView.register(ProfileHeaderCell.nib, forCellReuseIdentifier: ProfileHeaderCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ProfileTextType.chat.identifier)
        tableView.tableFooterView = UIView()
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .tableViewBackgroundColor
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.heightForHeader(at: section) > 0 else { return nil }
        
        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: tableView.frame.width,
                                                     height: CGFloat(viewModel.heightForHeader(at: section)))))
        view.backgroundColor = .tableViewBackgroundColor

        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let identifier = viewModel.getIdentifier(for: indexPath) else {
            assertionFailure("Could not get identifier for cell")
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.selectionStyle = .none
        
        if let customCell = cell as? ProfileHeaderCell {
            customCell.configure(with: viewModel.getUser())
            
            return customCell
        }
        
        cell.textLabel?.text = viewModel.getCellTitle(for: indexPath)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - ProfileViewControllerProtocol

extension ProfileViewController: ProfileViewControllerProtocol {

}
