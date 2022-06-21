//  ChatViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Gallery
import InputBarAccessoryView
import MessageKit
import RealmSwift
import UIKit

protocol ChatViewControllerProtocol: AnyObject {

}

class ChatViewController: MessagesViewController {
    
    // MARK: - Properties
    
    var viewModel: ChatViewModel!
    
    
    // MARK: - Lifecycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    
    // MARK: - Helpers

    private func configureUI() {

    }
    
}

// MARK: - ChatViewControllerProtocol

extension ChatViewController: ChatViewControllerProtocol {

}
