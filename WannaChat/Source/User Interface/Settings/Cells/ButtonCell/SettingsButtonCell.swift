//
//  SettingsButtonCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class SettingsButtonCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var actionButton: UIButton!
    
    // MARK: - Selectors
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Helpers
    
    func configure(with text: String?) {
        actionButton.setTitle(text ?? "", for: .normal)
    }
    
}
