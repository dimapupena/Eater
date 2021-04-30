//
//  LovedRestaurants.swift
//  Eater
//
//  Created by Dmitriy Pupena on 27.04.2021.
//

import Foundation
import UIKit

class UserLovedRestaurantVC: UIViewController {
    
    var openWebViewItem: ((_ link: String?) -> Void)?
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
        label.text = "Eater"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Your favourite restaurants"
        label.numberOfLines = 0
        return label
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
    
    func setupView() {
        setupBackButton()
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
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
        restaurantCollection.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        restaurantCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        restaurantCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        self.view.layoutIfNeeded()
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        restaurantCollection.collectionViewLayout = layout
    }
    
    @objc func backButtonClicked() {
        self.backButtonAction?()
    }
    
}

extension UserLovedRestaurantVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RestaurantManager.shared.getLovedRestaurantFromRealm()?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = restaurantCollection.dequeueReusableCell(withReuseIdentifier: "RestaurantViewCell", for: indexPath) as! RestaurantViewCell
        if let restaurantdata = RestaurantManager.shared.getLovedRestaurantFromRealm() {
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
        self.openWebViewItem?(RestaurantManager.shared.getLovedRestaurantFromRealm()?[indexPath.row].restrauntUrl)
    }
    
}
