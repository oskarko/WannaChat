//
//  UIViewController+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool) {
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationItem.scrollEdgeAppearance = navigationBarAppearance
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.compactAppearance = navigationBarAppearance
            navigationController?.setNeedsStatusBarAppearanceUpdate()
        }

        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
    }
}
