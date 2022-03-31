//
//  ProfileHeaderCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    @IBOutlet weak var profileStatusLabel: UILabel!

    // MARK: - Helpers
    
    func configure(with user: User?) {
        guard let user = user else { return }
        
        profileUsernameLabel.text = user.username
        profileStatusLabel.text = user.status
        setAvatar(user.avatarLink)
    }
    
    private func setAvatar(_ avatarLink: String) {
        if !avatarLink.isEmpty {
            FileStorage.downloadImage(imageURL: avatarLink) { [weak self] avatarImage in
                self?.profileImageView.image = avatarImage?.circleMasked
            }
        } else {
            self.profileImageView.image = UIImage(named: "avatar")?.circleMasked
        }
    }
}
