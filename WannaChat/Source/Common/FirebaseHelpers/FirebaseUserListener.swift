//
//  FirebaseUserListener.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Firebase
import Foundation

class FirebaseUserListener {
    
    static let shared = FirebaseUserListener()
    
    private init() { }
    
    // MARK: - Login
    
    func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            
            guard let authDataResult = authDataResult, authDataResult.user.isEmailVerified else {
                print("Email is not verified")
                completion(error, false)
                return
            }

            FirebaseUserListener.shared.downloadUserFromFirebase(userId: authDataResult.user.uid, email: email)
            completion(error, true)
        }
    }
    
    // MARK: - Register
    
    func registerUserWith(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            completion(error)
            
            if let authDataResult = authDataResult, error == nil {
                
                // send verification email
                authDataResult.user.sendEmailVerification { error in
                    if let error = error {
                        print("auth email sent with error: ", error.localizedDescription)
                    }
                }
                
                // create user and save it
                let user = User(id: authDataResult.user.uid,
                                username: email,
                                email: email,
                                pushId: "",
                                avatarLink: "",
                                status: "Hey there! I'm using WannaChat")
                saveUserLocally(user)
                self.saveUserToFireStore(user)
            }
        }
    }
    
    // MARK: - Log Out
    
    func logOutCurrentUser(completion: @escaping (_ error: Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: kCURRENTUSER)
            UserDefaults.standard.synchronize()
            completion(nil)
        } catch let error as NSError {
            print("Error login out: ", error.localizedDescription)
            completion(error)
        }
    }
    
    // MARK: - Resend link methods
    
    func resendVerificationEmail(email: String, completion: @escaping (_ error: Error?) -> Void) {
        
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                completion(error)
            })
        })
    }
    
    func resetPasswordFor(email: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }
    
    // MARK: - Save Users
    
    func saveUserToFireStore(_ user: User) {
        do {
            try firebaseReference(.user).document(user.id).setData(from: user)
        } catch {
            print(error.localizedDescription, "adding user")
        }
    }
    
    // MARK: - Download User From Firebase
    
    func downloadUserFromFirebase(userId: String, email: String? = nil) {
        firebaseReference(.user).document(userId).getDocument { querySnapshot, error in
            guard let document = querySnapshot else {
                print("No document for userId")
                return
            }

            do {
                if let user = try document.data(as: User.self) {
                    saveUserLocally(user)
                } else {
                    print("Document does not exist")
                }
            } catch {
                print("Error decoding user: ", error.localizedDescription)
            }
        }
    }
}
