//
//  LoginVC.swift
//  Eater
//
//  Created by Dmytro Pupena on 21.05.2021.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    var userLoggedInAction: (() -> Void)?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Login"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Email"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.backgroundColor = .clear
        textField.placeholder = "Email"
        textField.text = "mail@gmail.com"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Password"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.backgroundColor = .clear
        textField.placeholder = "Password"
        textField.text = "111111"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let signInButton: StandartActionButton = {
        let button = StandartActionButton()
        button.setText("Sign in", font: .boldSystemFont(ofSize: 14))
        button.backgroundColor = UIColor(hexString: "#2d74b3")
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: StandartActionButton = {
        let button = StandartActionButton()
        button.setText("Sign up", font: .boldSystemFont(ofSize: 14))
        button.backgroundColor = UIColor(hexString: "#2db35e")
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        setupView()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(hexString: "#5e918d")
        
        setupTitleLabel()
        setupLoginStackView()
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordField()
        setupSignInButton()
        setupSignUpButton()
    }
    
    func setupTitleLabel() {
        self.view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupLoginStackView() {
        self.view.addSubview(loginStackView)
        
        loginStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loginStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        loginStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setupEmailLabel() {
        loginStackView.addArrangedSubview(emailLabel)
        emailLabel.widthAnchor.constraint(equalToConstant: DeviceSize.width - 40).isActive = true
    }
    
    func setupEmailTextField() {
        loginStackView.addArrangedSubview(emailTextField)
        
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        emailTextField.leftViewMode = .always
        
        emailTextField.widthAnchor.constraint(equalToConstant: DeviceSize.width - 40).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupPasswordLabel() {
        loginStackView.addArrangedSubview(passwordLabel)
        passwordLabel.widthAnchor.constraint(equalToConstant: DeviceSize.width - 40).isActive = true
    }
    
    func setupPasswordField() {
        loginStackView.addArrangedSubview(passwordField)
        
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTextField.frame.height))
        passwordField.leftViewMode = .always
        
        passwordField.widthAnchor.constraint(equalToConstant: DeviceSize.width - 40).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupSignInButton() {
        loginStackView.addArrangedSubview(signInButton)

        signInButton.widthAnchor.constraint(equalToConstant: 92).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    func setupSignUpButton() {
        loginStackView.addArrangedSubview(signUpButton)
        
        signUpButton.widthAnchor.constraint(equalToConstant: 92).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    @objc private func signIn() {
        ClickWithDebounce.tapWithDebounce {
            self.showLoaderView()
            UserManager.sharedInstance.signInUser(email:  emailTextField.text ?? "", password: passwordField.text ?? "") { [weak self] success in
                if success {
                    self?.userLoggedInAction?()
                }
                self?.hideLoaderView()
            }
        }
    }
    
    @objc private func signUp() {
        ClickWithDebounce.tapWithDebounce {
            self.showLoaderView()
            UserManager.sharedInstance.signUpNewUser(email: emailTextField.text ?? "", password: passwordField.text ?? "") { [weak self] success in
                self?.hideLoaderView()
            }
        }
    }
}
