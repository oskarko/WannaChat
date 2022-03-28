//
//  String+Ext.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

extension String {
    func getFileName() -> String? {
        self.components(separatedBy: "_").last?
            .components(separatedBy: "?").first?
            .components(separatedBy: ".").first
    }
}
