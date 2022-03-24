//
//  SettingsButtonType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum SettingsButtonType: Int, CaseIterable {
    case tell
    case terms
}

extension SettingsButtonType {
    public var identifier: String {
        SettingsButtonCell.identifier
    }
    
    public var titleString: String {
        switch self {
        case .tell: return "Tell a Friend"
        case .terms: return "Terms and Conditions"
        }
    }
    
    public var height: Int {
        44
    }
}
