//
//  LoaderCircleView.swift
//  Eater
//
//  Created by Dmitriy Pupena on 05.05.2021.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    let loaderCircleView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loaderImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .lightGray
        self.alpha = 0.5
        
        self.addSubview(loaderCircleView)
        loaderCircleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loaderCircleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loaderCircleView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loaderCircleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        animateLoader()
    }
    
    func animateLoader() {
        UIView.animate(withDuration: 1, delay: 0, options: .repeat) {
            self.loaderCircleView.rotate360Degrees()
        } completion: { (success) in
            print("animation success")
        }

    }
}

extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 1, repeatCount: Float = .infinity) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = repeatCount
        layer.add(rotateAnimation, forKey: nil)
    }
}
