//
//  RestaurantView.swift
//  Eater
//
//  Created by Dmitriy Pupena on 29.03.2021.
//

import Foundation
import UIKit

protocol RestaurantViewDelegate: class {
    func bookStatusClicked(to newValue: Bool)
}

class RestaurantView: UIView {
    
    weak var delegate: RestaurantViewDelegate?
    var isFavourite: Bool = false {
        didSet {
            bookMark.image = isFavourite ? UIImage(named: "bookmark_black") : UIImage(named: "bookmark_white")
        }
    }
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private lazy var bookMark: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var sheffLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.text = "Our SHEFF: @sheffName@"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.text = "ADDRESS: @addressText@"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewParameters(_ content: RealmRestaurants) {
        loadData(content)
        setupViews()
    }
    
    private func loadData(_ data: RealmRestaurants){
        titleLabel.text = data.name
        descriptionLabel.text = data.placeDescription
        sheffLabel.text = sheffLabel.text?.replacingOccurrences(of: "@sheffName@", with: data.sheff ?? "")
        addressLabel.text = addressLabel.text?.replacingOccurrences(of: "@addressText@", with: data.address ?? "")
        ratingLabel.text = data.rating
        self.isFavourite = data.isFavourite
        
        logoImage.downloaded(from: data.mainPhotoUrl ?? "" , contentMode: .scaleToFill)
        headImage.downloaded(from: data.logoPhotoUrl ?? "", contentMode: .scaleToFill)
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setLogoImage()
        setBookMarkImage()
        setTitleLabel()
        setDescriptionLabel()
        setHeadImage()
        setSheffLabel()
        setAddressLabel()
        setRatingLabel()
    }
    
    private func setLogoImage() {
        addSubview(logoImage)
        
        logoImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 70).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func setBookMarkImage() {
        addSubview(bookMark)
        
        bookMark.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor).isActive = true
        bookMark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        bookMark.widthAnchor.constraint(equalToConstant: 40).isActive = true
        bookMark.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bokkStatusChanged))
        bookMark.isUserInteractionEnabled = true
        bookMark.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 15).isActive = true
        titleLabel.topAnchor.constraint(equalTo: logoImage.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: bookMark.leadingAnchor,constant: -5).isActive = true
    }
    
    private func setDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: bookMark.leadingAnchor,constant: -5).isActive = true
    }
    
    private func setHeadImage() {
        addSubview(headImage)
        
        headImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor , constant: 20).isActive = true
        headImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setSheffLabel() {
        addSubview(sheffLabel)
        
        sheffLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        sheffLabel.topAnchor.constraint(equalTo: headImage.bottomAnchor, constant: 15).isActive = true
        sheffLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setAddressLabel() {
        addSubview(addressLabel)
        
        addressLabel.topAnchor.constraint(equalTo: sheffLabel.bottomAnchor).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: sheffLabel.leadingAnchor).isActive = true
    }
    
    private func setRatingLabel() {
        addSubview(ratingLabel)
        
        ratingLabel.topAnchor.constraint(equalTo: sheffLabel.topAnchor).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ratingLabel.bottomAnchor.constraint(equalTo: addressLabel.bottomAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: sheffLabel.trailingAnchor).isActive = true
    }
    
    @objc func bokkStatusChanged()
    {
        self.isFavourite = !self.isFavourite
        delegate?.bookStatusClicked(to: self.isFavourite)
    }
}
