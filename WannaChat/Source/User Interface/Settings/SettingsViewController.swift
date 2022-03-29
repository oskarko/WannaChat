//  SettingsViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {

}

class SettingsViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SettingsViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(withTitle: "Settings", prefersLargeTitles: true)
        configureTableView()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func configureTableView() {
        tableView.register(SettingsHeaderCell.nib, forCellReuseIdentifier: SettingsHeaderCell.identifier)
        tableView.register(SettingsButtonCell.nib, forCellReuseIdentifier: SettingsButtonCell.identifier)
        tableView.register(SettingsTextCell.nib, forCellReuseIdentifier: SettingsTextCell.identifier)
        tableView.register(SettingsLogOutCell.nib, forCellReuseIdentifier: SettingsLogOutCell.identifier)
        tableView.tableFooterView = UIView()
    }
    
    private func configureUI() {
        view.backgroundColor = .tableViewBackgroundColor
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    // sections
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
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
        
        if let customCell = cell as? SettingsHeaderCell {
            customCell.configure(with: viewModel.getUser())
            
            return customCell
        }
        else if let customCell = cell as? SettingsButtonCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            
            return customCell
        }
        else if let customCell = cell as? SettingsTextCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            
            return customCell
        }
        else if let customCell = cell as? SettingsLogOutCell {
            customCell.configure(with: viewModel.getCellTitle(for: indexPath))
            customCell.delegate = viewModel
            
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

// MARK: - SettingsViewControllerProtocol

extension SettingsViewController: SettingsViewControllerProtocol {

}
