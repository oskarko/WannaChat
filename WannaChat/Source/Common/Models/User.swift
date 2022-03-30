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
import UIKit

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

func createDummyUsers() {
    
    let names = ["Gearge Duggan", "Alfie Thornton", "Alison Stamp", "Rachelle Neale", "Phil O'lowan", "Juanita Bate"]
    var imageIndex = 1
    var userIndex = 1
    
    for i in 0..<6 {
        let id = UUID().uuidString
        let fileDirectory = "Avatars/_\(id).jpg"
        
        if let userImage = UIImage(named: "user\(i + 1)") {
            FileStorage.uploadImage(userImage, directory: fileDirectory) { avatarLink in
                let user = User(id: id,
                                username: names[i],
                                email: "user\(userIndex)@mail.com",
                                pushId: "",
                                avatarLink: avatarLink ?? "",
                                status: Status(rawValue: i)?.stringValue ?? "")
                userIndex += 1
                FirebaseUserListener.shared.saveUserToFireStore(user)
            }
        }
        
        imageIndex += 1
        if imageIndex == 6 {
            imageIndex = 1
        }
    }
}
