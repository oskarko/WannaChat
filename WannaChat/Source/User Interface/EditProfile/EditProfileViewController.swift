//  EditProfileViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerProtocol: AnyObject {

}

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EditProfileViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureNavigationBar(withTitle: "Edit Profile", prefersLargeTitles: false)
    }

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .tableViewBackgroundColor

    }
    
    private func configureTableView() {
        tableView.register(EditProfileHeaderCell.nib, forCellReuseIdentifier: EditProfileHeaderCell.identifier)
        tableView.register(EditProfileTextFieldCell.nib, forCellReuseIdentifier: EditProfileTextFieldCell.identifier)
        tableView.register(SettingsTextCell.nib, forCellReuseIdentifier: SettingsTextCell.identifier)
        tableView.tableFooterView = UIView()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    // sections
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat(viewModel.heightForHeader(at: section))
    }
    
    // rows
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
        
        if let customCell = cell as? EditProfileHeaderCell {
            if let user = User.currentUser {
                customCell.configure(with: user)
            }
            
            return customCell
        }
        else if let customCell = cell as? EditProfileTextFieldCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            
            return customCell
        }
        else if let customCell = cell as? SettingsTextCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            
            return customCell
        } else {
            assertionFailure("Could not deque cell")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRow(at: indexPath))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - EditProfileViewControllerProtocol

extension EditProfileViewController: EditProfileViewControllerProtocol {

}
