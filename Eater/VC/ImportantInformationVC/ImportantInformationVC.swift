//
//  ImportantInformationVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.04.2021.
//

import Foundation
import UIKit

struct UserUsefulInformation {
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}

class ImportantInformationVC: UIViewController, GAEventTrackable {
    
    var importantInformation: UserUsefulInformation
    
    var backButtonAction: (() -> Void)?
    
    private let backButton: BackButton = {
       let button = BackButton()
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ".center"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.textColor = .black
        textView.text = ".center"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(importantInformation: UserUsefulInformation) {
        self.importantInformation = importantInformation
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setupBackButton()
        setupTitleView()
        setupTextView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openScreenEvent(screenTitle: GAOpenScreenTitles.importantInformationVC.rawValue)
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
    }
    
    private func setupTitleView() {
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: backButton.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backButton.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10).isActive = true
        
        textView.text = importantInformation.title
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        textView.text = importantInformation.description
    }
    
    @objc func backButtonClicked() {
        self.backButtonAction?()
    }
}
