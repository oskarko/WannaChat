//
//  EditProfileHeaderCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol EditProfileHeaderCellDelegate: AnyObject {
    func editButtonTapped()
}

class EditProfileHeaderCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: EditProfileHeaderCellDelegate?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Selectors
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        delegate?.editButtonTapped()
    }
    
    // MARK: - Helpers
    
    func configure(with user: User?) {
        guard let avatarLink = user?.avatarLink, !avatarLink.isEmpty else { return }

        FileStorage.downloadImage(imageURL: avatarLink) { [weak self] avatarImage in
            self?.avatarImageView.image = avatarImage?.circleMasked
        }
    }
}
