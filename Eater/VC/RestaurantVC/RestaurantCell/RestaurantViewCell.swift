//
//  RestaurantViewCell.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

class RestaurantViewCell: UICollectionViewCell {
    
    var content: RestaurantContent?
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.shadowRadius = 30
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    private lazy var headImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.shadowRadius = 30
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logoImage.removeFromSuperview()
        headImage.removeFromSuperview()
    }
    
    func setupViewParameters(_ content: RestaurantContent) {
        self.content = content
        logoImage.downloaded(from: content.hearePhoto, contentMode: .scaleToFill)
        headImage.downloaded(from: content.photo, contentMode: .scaleToFill)
        
        setupViews()
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setLogoImage()
        setHeadImage()
    }
    
    private func setLogoImage() {
        contentView.addSubview(logoImage)
        
        logoImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setHeadImage() {
        contentView.addSubview(headImage)
        
        headImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        headImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor , constant: 20).isActive = true
        headImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        headImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
