//  EditProfileViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import ProgressHUD
import UIKit

protocol EditProfileViewControllerProtocol: AnyObject {
    func refreshCells(at indexPaths: [IndexPath])
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
        tableView.reloadData()
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
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension EditProfileViewController: UITableViewDataSource, UITableViewDelegate {
    // sections
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.heightForHeader(at: section) > 0 else { return nil }

        let view = UIView(frame: CGRect(origin: .zero,
                                        size: CGSize(width: CGFloat(viewModel.heightForHeader(at: section)),
                                                     height: tableView.frame.width)))
        view.backgroundColor = .tableViewBackgroundColor

        return view
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
            customCell.configure(with: viewModel.getUser())
            customCell.delegate = self
            
            return customCell
        }
        else if let customCell = cell as? EditProfileTextFieldCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            customCell.delegate = self
            
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
    func refreshCells(at indexPaths: [IndexPath]) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.beginUpdates()
            self?.tableView.reloadRows(at: indexPaths, with: .none)
            self?.tableView.endUpdates()
        }
    }
}

// MARK: - EditProfileHeaderCellDelegate

extension EditProfileViewController: EditProfileHeaderCellDelegate {
    func editButtonTapped() {
        viewModel.showImageGallery()
    }
}

// MARK: - EditProfileTextFieldCellDelegate

extension EditProfileViewController: EditProfileTextFieldCellDelegate {
    func usernameDidChange(_ username: String) {
        viewModel.usernameDidChange(username)
    }
}
