//
//  RestaurantViewCell.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

protocol RestaurantViewCellDelegate: AnyObject {
    func showRestaurantPreview()
}

class RestaurantViewCell: UICollectionViewCell {
    
    var restaurantView: RestaurantView = RestaurantView()
    var restaurantViewModel: RestaurantCellViewModel!
    
    weak var delegate: RestaurantViewCellDelegate? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        restaurantView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewParameters(_ restaurantName: String) {
        restaurantViewModel = RestaurantCellViewModel(restaurantName)
        setupRestaurantView()
    }
    
    func setupRestaurantView() {
        guard let rastaurant = restaurantViewModel.getRestaurant() else { return }
        restaurantView.setupViewParameters(rastaurant)
        self.contentView.addSubview(restaurantView)
        restaurantView.setZeroConstraits(with: self.contentView)
        
        restaurantView.openPreviewView = { [weak self] in
            self?.delegate?.showRestaurantPreview()
        }
    }
}

extension RestaurantViewCell: RestaurantViewDelegate {
    func getLocationClicked() -> LocationModel? {
        restaurantViewModel.GAGetDiractionEvent()
        return restaurantViewModel.getCoordinatesRestaurant()
    }
    
    func bookStatusClicked(to newValue: Bool) {
        restaurantViewModel.GAMarkAsLovedEvent(to: newValue)
        restaurantViewModel.updateIsFaforiteStatus(to: newValue)
    }
}
