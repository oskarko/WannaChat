//
//  ProfileHeaderType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum ProfileHeaderType: Int, CaseIterable {
    case profile
}

extension ProfileHeaderType {
    public var identifier: String {
        switch self {
        case .profile: return ProfileHeaderCell.identifier
        }
    }
    
    public var titleString: String {
        switch self {
        case .profile: return ""
        }
    }
    
    public var height: Int {
        switch self {
        case .profile: return 200
        }
    }
}
