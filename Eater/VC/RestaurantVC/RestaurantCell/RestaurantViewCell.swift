//
//  RestaurantViewCell.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

class RestaurantViewCell: UICollectionViewCell {
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.downloaded(from: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMJpLJJY_vaLs0MLWDGLosA5tzKfrqSnVcjQ&usqp=CAU")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var headImage: UIImageView = {
        let imageView = UIImageView()
        imageView.downloaded(from: "https://m.media-amazon.com/images/M/MV5BOTM2NTI3NTc3Nl5BMl5BanBnXkFtZTgwNzM1OTQyNTM@._V1_SX300.jpg", contentMode: .scaleToFill)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.shadowRadius = 30
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {

        self.translatesAutoresizingMaskIntoConstraints = false
        
        setLogoImage()
        setHeadImage()
    }
    
    func setLogoImage() {
        self.addSubview(logoImage)
        
        logoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setHeadImage() {
        self.addSubview(headImage)
        
        headImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor , constant: 20).isActive = true
        headImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        headImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50).isActive = true
    }
}
