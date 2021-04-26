//
//  RestaurantCellModel.swift
//  Eater
//
//  Created by Dmitriy Pupena on 26.04.2021.
//

import Foundation

class RestaurantCellModel {
    
    func updateIsFaforiteStatus(to newStatus: Bool, restaurantName: String) {
        RestaurantManager.shared.updateFavouriteStatus(to: newStatus, restaurantName: restaurantName)
    }
    
}
