//
//  EditProfileHeaderType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum EditProfileHeaderType: Int, CaseIterable {
    case profile
    case textField
}

extension EditProfileHeaderType {
    public var identifier: String {
        switch self {
        case .profile: return EditProfileHeaderCell.identifier
        case .textField: return EditProfileTextFieldCell.identifier
        }
    }
    
    public var height: Int {
        switch self {
        case .profile: return 100
        case .textField: return 44
        }
    }
}
