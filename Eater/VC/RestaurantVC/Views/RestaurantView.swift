//
//  RestaurantView.swift
//  Eater
//
//  Created by Dmitriy Pupena on 29.03.2021.
//

import Foundation
import UIKit
import MapKit

protocol RestaurantViewDelegate: class {
    func bookStatusClicked(to newValue: Bool)
    func getLocationClicked() -> LocationModel?
}

class RestaurantView: UIView {
    
    var openPreviewView: (() -> Void)?
    
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
    
    private lazy var getLocationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "getLocation")
        return imageView
    }()
    
    private lazy var restaurantPreviewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "restaurantPreview")
        return imageView
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
        setGetDirectionImage()
        setRestaurantPreviewImage()
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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bookStatusChanged))
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
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
    }
    
    private func setHeadImage() {
        addSubview(headImage)
        
        headImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        headImage.topAnchor.constraint(equalTo: logoImage.bottomAnchor , constant: 20).isActive = true
        headImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        headImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
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
        addressLabel.trailingAnchor.constraint(equalTo: sheffLabel.trailingAnchor).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: sheffLabel.leadingAnchor).isActive = true
    }
    
    private func setRatingLabel() {
        addSubview(ratingLabel)
        
        ratingLabel.topAnchor.constraint(equalTo: sheffLabel.topAnchor).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setGetDirectionImage() {
        addSubview(getLocationImage)
        
        getLocationImage.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        getLocationImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        getLocationImage.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor).isActive = true
        getLocationImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        getLocationImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(createOpenDirectionAlert))
        getLocationImage.isUserInteractionEnabled = true
        getLocationImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setRestaurantPreviewImage() {
        addSubview(restaurantPreviewImage)
        
        restaurantPreviewImage.topAnchor.constraint(equalTo: getLocationImage.topAnchor).isActive = true
        restaurantPreviewImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        restaurantPreviewImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        restaurantPreviewImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openRestaurantPreviewVideo))
        restaurantPreviewImage.isUserInteractionEnabled = true
        restaurantPreviewImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func createOpenDirectionAlert() {
        let alert = UIAlertController(title: "Do you want to get direction to restaurant", message: "You will get way to restaurant. It can help you to understand where restaurant is and how many time you need to get there.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open map", style: .default, handler: { (action) in
            self.getDirectionAction()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    @objc private func openRestaurantPreviewVideo() {
        self.openPreviewView?()
    }
    
    @objc func bookStatusChanged()
    {
        self.isFavourite = !self.isFavourite
        delegate?.bookStatusClicked(to: self.isFavourite)
    }
    
    @objc private func getDirectionAction()
    {
        guard let coordinates = delegate?.getLocationClicked() else { return }
        openMapForPlace(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    private func openMapForPlace(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let coodinate =  CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coodinate, addressDictionary: nil))
        mapItem.name = "Test"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
