//
//  SettingsTextType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum SettingsTextType: Int, CaseIterable {
    case version
    case logout
}

extension SettingsTextType {
    public var identifier: String {
        switch self {
        case .version: return SettingsTextCell.identifier
        case .logout: return SettingsLogOutCell.identifier
        }
    }
    
    public var titleString: String {
        switch self {
        case .version: return "App Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
        case .logout: return "Log Out"
        }
    }
    
    public var height: Int {
        44
    }
}
