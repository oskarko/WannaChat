//
//  SettingsHeaderCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class SettingsHeaderCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileStatusLabel: UILabel!
    
    // MARK: - Helpers
    
    func configure(with user: User) {
        profileUsernameLabel.text = user.username
        profileStatusLabel.text = user.status
        
        //profileImageView
    }
}