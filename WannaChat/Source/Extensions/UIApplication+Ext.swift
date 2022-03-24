//
//  UIApplication+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {

    static var rootViewController: UIViewController {
        set {
            UIApplication.shared.windows.first?.rootViewController = newValue
        }
        get {
            guard let vc = UIApplication.shared.windows.first?.rootViewController else {
                let vc = AuthRouter.getViewController()
                UIApplication.shared.windows.first?.rootViewController = vc

                return vc
            }

            return vc
        }
    }
}
