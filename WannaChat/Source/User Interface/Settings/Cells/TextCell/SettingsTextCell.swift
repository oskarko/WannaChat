//
//  SettingsTextCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class SettingsTextCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var sTextLabel: UILabel!
    
    // MARK: - Helpers
    
    func configure(with text: String?) {
        sTextLabel.text = text ?? ""
    }
    
}
