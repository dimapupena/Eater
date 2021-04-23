//
//  HeadViewController.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit

class HeadViewController: UIViewController {
    
    var onButtonClick: (() -> Void)?
    var userInformationAction: (() -> Void)?
    
    let backgroundView: UIImageView = {
        let view =  UIImageView()
        view.image = UIImage(named: "headBackground")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let userInformationbutton: InformationButton = {
        let button = InformationButton()
        button.addTarget(self, action: #selector(userInformationButtonClicked), for: .touchUpInside)
        return button
    }()
    
    let actionButton: StandartActionButton = {
        let button = StandartActionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setText("sadad", font: .systemFont(ofSize: 18))
        button.backgroundColor = UIColor(hexString: "#699CFC")
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        setupViews()
    }
    
    func setupViews() {
        setupBackgroundView()
        setupUserInformationButton()
        setupActionButton()
    }
    
    func setupBackgroundView() {
        self.view.addSubview(backgroundView)
        
        backgroundView.setZeroConstraits(with: self.view)
    }
    
    func setupActionButton() {
        self.view.addSubview(actionButton)
        
        actionButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: self.view.bounds.height / 4).isActive = true
        actionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        actionButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        actionButton.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    func setupUserInformationButton() {
        self.view.addSubview(userInformationbutton)
        
        userInformationbutton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        userInformationbutton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
    
    @objc func buttonClick() {
        self.onButtonClick?()
    }
    
    @objc func userInformationButtonClicked() {
        self.userInformationAction?()
    }
}
