//
//  InformationButton.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.04.2021.
//

import Foundation
import UIKit

class CustonImageButton: UIButton {
    
    var imageName: String = ""
    
    init(imageName: String) {
        super.init(frame: .zero)
        self.imageName = imageName
        setupSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSelf() {
        let image = UIImage(named: self.imageName)?.resize(targetSize: CGSize(width: 40, height: 40))
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setImage(image, for: .normal)
        self.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    }
}
