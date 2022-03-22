//  AuthViewModel.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation
import ProgressHUD

class AuthViewModel {
    
    // MARK: - Properties
    
    weak var view: AuthViewControllerProtocol?
    var router: AuthRouter?
    
    private var isLogin = true
    
    // MARK: - Helpers
    
    func forgotPasswordButtonTapped(with email: String?) {
        guard let email = email, !email.isEmpty else {
            view?.showMessage("Email is required", type: .error)
            return
        }
        
        resetPasswordFor(email: email)
    }
    
    func resendEmailButtonTapped(with email: String?) {
        guard let email = email, !email.isEmpty else {
            view?.showMessage("Email is required", type: .error)
            return
        }
        
        resendVerificationEmail(email: email)
    }
    
    func loginButtonTapped(with email: String?, password: String?, repeatPassword: String?) {
        guard
            let email = email, !email.isEmpty, let password = password, !password.isEmpty
        else {
            view?.showMessage("All fields are required", type: .error)
            return
        }
        
        if isLogin {
            loginUserWith(email: email, password: password)
        } else {
            // signUp
            guard let repeatPassword = repeatPassword, !repeatPassword.isEmpty else {
                view?.showMessage("All fields are required", type: .error)
                return
            }
            
            if password == repeatPassword {
                registerUserWith(email: email, password: password)
            } else {
                view?.showMessage("Passwords don't match", type: .error)
            }
        }
    }
    
    func signUpButtonTapped() {
        isLogin.toggle()
        view?.updateUIFor(login: isLogin)
    }
    
}

private extension AuthViewModel {
    
    func loginUserWith(email: String, password: String) {
        FirebaseUserListener.shared.loginUserWith(email: email, password: password) { [weak self] error, isEmailVerified in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.showMessage(error.localizedDescription, type: .error)
            } else {
                if isEmailVerified {
                    print("User has logged in with email: ", User.currentUser?.email ?? "")
                    self.router?.showMainView()
                } else {
                    self.view?.showMessage("Please, verify email.", type: .error)
                    self.view?.enableResendEmailButton()
                }
            }
        }
    }
    
    func registerUserWith(email: String, password: String) {
        FirebaseUserListener.shared.registerUserWith(email: email, password: password) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.showMessage(error.localizedDescription, type: .error)
            } else {
                self.view?.showMessage("Verification email sent.", type: .success)
                self.view?.enableResendEmailButton()
            }
        }
    }
    
    func resetPasswordFor(email: String) {
        FirebaseUserListener.shared.resetPasswordFor(email: email) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.showMessage(error.localizedDescription, type: .error)
            } else {
                self.view?.showMessage("Reset link sent to email", type: .success)
            }
        }
    }
    
    func resendVerificationEmail(email: String) {
        FirebaseUserListener.shared.resendVerificationEmail(email: email) { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                self.view?.showMessage(error.localizedDescription, type: .error)
            } else {
                self.view?.showMessage("New verification email sent!", type: .success)
            }
        }
    }
}
