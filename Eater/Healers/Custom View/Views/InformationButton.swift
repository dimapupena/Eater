//
//  InformationButton.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.04.2021.
//

import Foundation
import UIKit

class InformationButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        let image = UIImage(named: "detailedInformation")?.resize(targetSize: CGSize(width: 40, height: 40))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
