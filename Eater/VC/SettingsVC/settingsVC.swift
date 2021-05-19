//
//  SettingsVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 05.05.2021.
//

import Foundation
import UIKit

class SettingsVC: UIViewController, GAEventTrackable {
    
    var backButtonAction: (() -> Void)?
    var changeBackgroundAction: (() -> Void)?
    
    private let backButton: BackButton = {
        let button = BackButton()
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let changeBackgroundButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(changeBackgroundClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .lightGray
        setupBackButton()
        setupChangeBackgroundButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openScreenEvent(screenTitle: GAOpenScreenTitles.settingsVC.rawValue)
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    func setupChangeBackgroundButton() {
        view.addSubview(changeBackgroundButton)
        
        changeBackgroundButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        changeBackgroundButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        changeBackgroundButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        changeBackgroundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func backButtonClicked() {
        self.backButtonAction?()
    }
    
    @objc func changeBackgroundClicked() {
        self.changeBackgroundAction?()
    }
    
}
