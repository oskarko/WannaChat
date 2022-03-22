//  AuthViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import ProgressHUD
import UIKit

protocol AuthViewControllerProtocol: AnyObject {
    func updateUIFor(login: Bool)
    func showMessage(_ message: String, type: HUDMessageType)
    func enableResendEmailButton()
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
        setUpTextFieldDelegates()
        setUpBackgroundTap()
    }

    // MARK: - Selectors

    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        viewModel.forgotPasswordButtonTapped(with: emailTextField.text)
    }
    
    @IBAction func resendEmailButtonTapped(_ sender: UIButton) {
        viewModel.resendEmailButtonTapped(with: emailTextField.text)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        viewModel.loginButtonTapped(with: emailTextField.text,
                                    password: passwordTextField.text,
                                    repeatPassword: repeatPasswordTextField.text)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        viewModel.signUpButtonTapped()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(textField)
    }
    
    @objc func backgroundDidTap() {
        view.endEditing(false)
    }
    
    // MARK: - Helpers

    private func configureUI() {
        updateUIFor(login: true)
    }
    
    private func setUpTextFieldDelegates() {
        [emailTextField, passwordTextField, repeatPasswordTextField].forEach {
            $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    private func setUpBackgroundTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundDidTap))
        view.addGestureRecognizer(tap)
    }
    
    private func updatePlaceholderLabels(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            emailLabel.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabel.text = textField.hasText ? "Password" : ""
        case repeatPasswordTextField:
            repeatPasswordLabel.text = textField.hasText ? "Repeat Password" : ""
        default:
            break
        }
    }
}

// MARK: - AuthViewControllerProtocol

extension AuthViewController: AuthViewControllerProtocol {
    func updateUIFor(login: Bool) {
        loginButton.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        signUpButton.setTitle(login ? "Sign up" : "Log in", for: .normal)
        signUpLabel.text = login ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.repeatPasswordLabel.isHidden = login
            self?.repeatPasswordTextField.isHidden = login
            self?.repeatPasswordLineView.isHidden = login
        }
    }
    
    func showMessage(_ message: String, type: HUDMessageType) {
        DispatchQueue.main.async {
            switch type {
            case .success: ProgressHUD.showSuccess(message)
            case .error: ProgressHUD.showFailed(message)
            }
        }
    }
    
    func enableResendEmailButton() {
        DispatchQueue.main.async { [weak self] in
            self?.resendEmailButton.isHidden = false
        }
    }
}
