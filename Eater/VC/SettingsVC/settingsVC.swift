//
//  settingsVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 05.05.2021.
//

import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    var backButtonAction: (() -> Void)?
    
    private let backButton: BackButton = {
        let button = BackButton()
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .youtubeRed
        setupBackButton()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc func backButtonClicked() {
        self.backButtonAction?()
    }
    
}
