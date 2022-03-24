//
//  SettingsLogOutCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol SettingsLogOutCellDelegate: AnyObject {
    func logOutButtonTapped()
}

class SettingsLogOutCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var logOutButton: UIButton!
    
    weak var delegate: SettingsLogOutCellDelegate?
    
    // MARK: - Selectors
    
    @IBAction func logOutButtonTapped(_ sender: UIButton) {
        delegate?.logOutButtonTapped()
    }
    
    // MARK: - Helpers
    
    func configure(with text: String?) {
        logOutButton.setTitle(text ?? "", for: .normal)
    }
    
}
