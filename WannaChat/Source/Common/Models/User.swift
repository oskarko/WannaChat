//
//  User.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct User: Codable {
    var id: String
    var username: String
    var email: String
    var pushId: String
    var avatarLink: String
    var status: String
    
    static var currentId: String? {
        Auth.auth().currentUser?.uid
    }
    
    static var currentUser: User? {
        if let dictionary = UserDefaults.standard.data(forKey: kCURRENTUSER),
            Auth.auth().currentUser != nil {
            do {
                let user = try JSONDecoder().decode(User.self, from: dictionary)
                
                return user
            } catch {
                print("Error decoding user from user defaults: ", error.localizedDescription)
            }
        }

        return nil
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id && lhs.username == rhs.username && lhs.email == rhs.email
    }
}

func saveUserLocally(_ user: User) {
    do {
        let data = try JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: kCURRENTUSER)
    } catch {
        print("Error saving user locally: ", error.localizedDescription)
    }
}
