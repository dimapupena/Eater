//
//  RestaurantVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

class RestaurantVC: UIViewController, GAEventTrackable {
    
    var restaurantdata: [RestaurantContent]? {
        get {
            return ConfigManager.sharer.appConfiguration?.restaurants
        }
    }
    
    var openWebViewItem: ((_ link: String?) -> Void)?
    var backButtonAction: (() -> Void)?
    var openUserLoved: (() -> Void)?
    
    private let backButton: BackButton = {
        let button = BackButton()
        button.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Eater"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "You can choose some restaurant and can get your wonderful food"
        label.numberOfLines = 0
        return label
    }()
    
    private let lovedRestaurant: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "lovedRestaurants")
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.layer.shadowRadius = 30
        imageView.layer.shadowOpacity = 0.3
        return imageView
    }()
    
    private lazy var restaurantCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RestaurantViewCell.self, forCellWithReuseIdentifier: "RestaurantViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(hexString: "#FFBEED")
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        openScreenEvent(screenTitle: GAOpenScreenTitles.restaurantVC.rawValue)
    }
    
    func setupView() {
        setupBackButton()
        setupLovedRestaurant()
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    func setupLovedRestaurant() {
        view.addSubview(lovedRestaurant)
        
        lovedRestaurant.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        lovedRestaurant.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        lovedRestaurant.heightAnchor.constraint(equalToConstant: 40).isActive = true
        lovedRestaurant.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(takeUserLoved))
        lovedRestaurant.isUserInteractionEnabled = true
        lovedRestaurant.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: lovedRestaurant.leadingAnchor, constant: -10).isActive = true
    }
    
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        
        descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(restaurantCollection)
        
        restaurantCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        restaurantCollection.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
        restaurantCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        restaurantCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.view.layoutIfNeeded()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        restaurantCollection.collectionViewLayout = layout
    }
    
    func createOpenLinkAlert(_ indexPath: IndexPath) {
        guard let restaurant = self.restaurantdata?[indexPath.row] else { return }
        let alert = UIAlertController(title: "Whith way you want to use", message: "Please choose one of the ways for open restaurant website", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "In this App", style: .default, handler: { (action) in
            self.openRestaurantWebSite(restaurantTitle: restaurant.name, restaurantLink: restaurant.url, inApp: true)
            self.openWebViewItem?(restaurant.url)
        }))
        alert.addAction(UIAlertAction(title: "In Web browser", style: .default, handler: { (action) in
            guard let restaurantUrl = URL(string: restaurant.url) else { return }
            self.openRestaurantWebSite(restaurantTitle: restaurant.name, restaurantLink: restaurant.url, inApp: false)
            UIApplication.shared.open(restaurantUrl)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func backButtonClicked() {
        self.backButtonAction?()
    }
    
    @objc func takeUserLoved() {
        self.openUserLoved?()
    }
    
}

extension RestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantdata?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "RestaurantViewCell", for: indexPath) as! RestaurantViewCell
        if let restaurantdata = self.restaurantdata {
            cell.setupViewParameters(restaurantdata[indexPath.row].name)
            print(indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 120, height: UIScreen.main.bounds.size.height - 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createOpenLinkAlert(indexPath)
    }
}
