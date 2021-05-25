//
//  SettingsVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 05.05.2021.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController, GAEventTrackable {
    
    var backButtonAction: (() -> Void)?
    var changeBackgroundAction: (() -> Void)?
    var logOutAction: (() -> Void)?
    var userDeleteAction: (() -> Void)?
    
    private let backButton: BackButton = {
        let button = BackButton()
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let changeBackgroundButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 99, green: 147, blue: 191)
        button.setTitle("Change main background", for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeBackgroundClicked), for: .touchUpInside)
        return button
    }()
    
    private let userDeleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 227, green: 89, blue: 89)
        button.setTitle("Delete user", for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(userDeleteClicked), for: .touchUpInside)
        return button
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 224, green: 114, blue: 114)
        button.setTitle("Log out", for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logOutClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .lightGray
        setupBackButton()
        setupChangeBackColorButton()
        setupLogOutButton()
        setupUserDeleteButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openScreenEvent(screenTitle: GAOpenScreenTitles.settingsVC.rawValue)
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    private func setupChangeBackColorButton() {
        view.addSubview(changeBackgroundButton)
        
        changeBackgroundButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        changeBackgroundButton.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 10).isActive = true
        changeBackgroundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        changeBackgroundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupLogOutButton() {
        view.addSubview(logOutButton)
        
        logOutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupUserDeleteButton() {
        view.addSubview(userDeleteButton)
        
        userDeleteButton.leadingAnchor.constraint(equalTo: logOutButton.leadingAnchor).isActive = true
        userDeleteButton.trailingAnchor.constraint(equalTo: logOutButton.trailingAnchor).isActive = true
        userDeleteButton.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -20).isActive = true
        userDeleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    @objc private func backButtonClicked() {
        self.backButtonAction?()
    }
    
    @objc private func changeBackgroundClicked() {
        self.changeBackgroundAction?()
    }
    
    @objc private func logOutClicked() {
        self.logOutAction?()
    }
    
    @objc private func userDeleteClicked() {
        self.showLoaderView()
        UserManager.sharedInstance.deleteUser { [weak self] success in
            self?.hideLoaderView()
            if success {
                self?.userDeleteAction?()
            }
        }
    }
    
}
