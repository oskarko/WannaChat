//  AuthViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol AuthViewControllerProtocol: AnyObject {

}

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordLineView: UIView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var resendEmailButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: AuthViewModel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Selectors

    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        viewModel.forgotPasswordButtonTapped()
    }
    
    @IBAction func resendEmailButtonTapped(_ sender: UIButton) {
        viewModel.resendEmailButtonTapped()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.loginButtonTapped()
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        viewModel.signUpButtonTapped()
    }
    
    // MARK: - Helpers

    private func configureUI() {

    }
    
}

// MARK: - AuthViewControllerProtocol

extension AuthViewController: AuthViewControllerProtocol {

}
