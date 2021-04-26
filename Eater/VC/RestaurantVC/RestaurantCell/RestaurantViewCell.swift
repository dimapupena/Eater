//
//  RestaurantViewCell.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

class RestaurantViewCell: UICollectionViewCell {
    
    var restaurantName: String = ""
    
    var restaurantView: RestaurantView = RestaurantView()
    var restaurantModel: RestaurantCellModel = RestaurantCellModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        restaurantView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewParameters(_ restaurantName: String) {
        self.restaurantName = restaurantName
        setupRestaurantView()
    }
    
    func setupRestaurantView() {
        guard let rastaurant = RestaurantManager.shared.getRestaurantFromRealm(restaurantName: restaurantName) else { return }
        restaurantView.setupViewParameters(rastaurant)
        self.contentView.addSubview(restaurantView)
        restaurantView.setZeroConstraits(with: self.contentView)
    }
}

extension RestaurantViewCell: RestaurantViewDelegate {
    func bookStatusClicked(to newValue: Bool) {
        restaurantModel.updateIsFaforiteStatus(to: newValue, restaurantName: self.restaurantName)
    }
}
