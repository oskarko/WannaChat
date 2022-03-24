//
//  SettingsHeaderType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum SettingsHeaderType: Int, CaseIterable {
    case profile
}

extension SettingsHeaderType {
    public var identifier: String {
        SettingsHeaderCell.identifier
    }
    
    public var height: Int {
        80
    }
}
