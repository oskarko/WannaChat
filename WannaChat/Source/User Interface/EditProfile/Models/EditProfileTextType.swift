//
//  EditProfileTextType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum EditProfileTextType: Int, CaseIterable {
    case status
}

extension EditProfileTextType {
    public var identifier: String {
        switch self {
        case .status: return SettingsTextCell.identifier
        }
    }
    
    public var height: Int {
        44
    }
}
