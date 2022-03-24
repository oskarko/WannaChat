//
//  EditProfileHeaderCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class EditProfileHeaderCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Selectors
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Helpers
    
    func configure(with user: User) {
        
    }
}
