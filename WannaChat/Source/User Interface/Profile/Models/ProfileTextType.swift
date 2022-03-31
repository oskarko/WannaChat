//
//  ProfileTextType.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum ProfileTextType: Int, CaseIterable {
    case chat
}

extension ProfileTextType {
    public var identifier: String {
        switch self {
        case .chat: return "cell"
        }
    }
    
    public var titleString: String {
        switch self {
        case .chat: return "Start Chat"
        }
    }
    
    public var height: Int {
        44
    }
}
