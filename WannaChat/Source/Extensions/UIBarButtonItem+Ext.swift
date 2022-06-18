//
//  UIBarButtonItem+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    static func newChatButton(_ target: Any, _ action: Selector) -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: target, action: action)
        button.tintColor = .systemBlue
        
        return button
    }
    
}
