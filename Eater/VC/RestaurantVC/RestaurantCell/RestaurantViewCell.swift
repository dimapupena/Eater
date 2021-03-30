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
    
    var restaurantView: RestaurantView = RestaurantView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewParameters(_ content: RestaurantContent) {
        self.content = content
        setupRestaurantView()
    }
    
    func setupRestaurantView() {
        restaurantView.setupViewParameters(self.content!)
        self.contentView.addSubview(restaurantView)
        restaurantView.setZeroConstraits(with: self.contentView)
    }
    
}
