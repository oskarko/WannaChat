//
//  EditProfileTextFieldCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol EditProfileTextFieldCellDelegate: AnyObject {
    func usernameDidChange(_ username: String)
}

class EditProfileTextFieldCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    weak var delegate: EditProfileTextFieldCellDelegate?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        usernameTextField.delegate = self
    }
    
    // MARK: - Helpers
    
    func configure(with text: String?) {
        usernameTextField.text = text
    }
}

// MARK: - UITextFieldDelegate

extension EditProfileTextFieldCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let username = textField.text, !username.isEmpty {
            delegate?.usernameDidChange(username)
        }
        textField.resignFirstResponder()
        return false
    }
}
