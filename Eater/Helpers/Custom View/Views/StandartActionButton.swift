//
//  StandartActionButton.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit

class StandartActionButton: UIButton {
    
    private let buttonText : UILabel = {
        let label = UILabel()
        //label.font = UIFont(name: "NotoSans-Bold", size: 11)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    convenience init(frame: CGRect, buttonTitle: String) {
        self.init(frame: frame)
        self.buttonText.text = buttonTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTitle()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func setupTitle() {
        self.addSubview(buttonText)
        
        buttonText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func setTextColor(_ color : UIColor) {
        self.buttonText.textColor = color
    }
    
    func setText(_ text : String, font : UIFont) {
        self.buttonText.text = text
//        buttonText.addCharacterSpacing(2)
        self.buttonText.font = font
    }
    
}
