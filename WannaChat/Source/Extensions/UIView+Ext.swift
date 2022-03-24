//
//  UIView+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import UIKit

public extension UIView {
    /// Get the file name of the View.
    static var identifier: String {
        return String(describing: self)
    }

    /// Get the Nib instance from the file name.
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
