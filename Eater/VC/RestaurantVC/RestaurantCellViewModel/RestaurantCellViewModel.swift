//
//  RestaurantCellViewModel.swift
//  Eater
//
//  Created by Dmitriy Pupena on 26.04.2021.
//

import Foundation

class RestaurantCellViewModel {
    
    var restaurantName: String = ""
    
    init(_ restaurantName: String) {
        self.restaurantName = restaurantName
    }
    
    func updateIsFaforiteStatus(to newStatus: Bool) {
        RestaurantManager.shared.updateFavouriteStatus(to: newStatus, restaurantName: restaurantName)
    }
    
    func getRestaurant() -> RealmRestaurants? {
        return RestaurantManager.shared.getRestaurantFromRealm(restaurantName: restaurantName)
    }
    
    func getCoordinatesRestaurant() -> LocationModel? {
        guard let restaurant = self.getRestaurant() else { return nil }
        print("latitude: \(restaurant.latitude.value), longitude: \(restaurant.longitude.value)")
        return LocationModel(latitude: restaurant.latitude.value, longitude: restaurant.longitude.value)
    }
    
}

//MARK: Google Analytics
extension RestaurantCellViewModel {
    func GAMarkAsLovedEvent(to newValue: Bool) {
        guard let restaurant = getRestaurant() else { return }
        GATraker.shared.markAsUserLoved(eventTitle: GAEventsTitle.markRestaurantAsLoved.rawValue, restaurantTitle: restaurant.name, restaurantLink: restaurant.restrauntUrl ?? "", restaurantRating: Double(restaurant.rating ?? "None"), isLoved: newValue)
    }
    
    func GAGetDiractionEvent() {
        guard let restaurant = getRestaurant() else { return }
        GATraker.shared.getDirectionToRestaurant(eventTitle: restaurant.name, restaurantTitle: restaurant.name, restaurantLatitude: restaurant.latitude.value, restaurantLongitude: restaurant.longitude.value)
    }
}
