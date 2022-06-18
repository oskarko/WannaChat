//
//  ChatCell.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messsageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unreadMessagesView: UIView!
    @IBOutlet weak var unreadMessagesLabel: UILabel!
    

    // MARK: - Helpers
    
    func configure(with recent: RecentChat) {
        nameLabel.text = recent.receiverName
        messsageLabel.text = recent.lastMessage
        unreadMessagesView.isHidden = recent.unreadCounter == .zero
        unreadMessagesLabel.text = "\(recent.unreadCounter)"
        dateLabel.text = (recent.date ?? Date()).getTimeElapsed()
        
        setAvatar(recent.avatarLink)
    }
    
    private func setAvatar(_ avatarLink: String) {
        if !avatarLink.isEmpty {
            FileStorage.downloadImage(imageURL: avatarLink) { [weak self] avatarImage in
                self?.avatarImageView.image = avatarImage?.circleMasked
            }
        } else {
            self.avatarImageView.image = UIImage(named: "avatar")?.circleMasked
        }
    }
    
}
