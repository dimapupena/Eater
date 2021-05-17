//
//  GAEventTrackable.swift
//  Eater
//
//  Created by Dmitriy Pupena on 17.05.2021.
//

import Foundation

protocol GAEventTrackable {
    func openScreenEvent(screenTitle: String)
    func openRestaurantWebSite(restaurantTitle: String, restaurantLink: String, inApp: Bool)
}

extension GAEventTrackable {
    
    func openScreenEvent(screenTitle: String) {
        GATraker.shared.openScreenEvent(eventTitle: GAEventsTitle.openScreen.rawValue, screenTitle: screenTitle)
    }
    
    func openRestaurantWebSite(restaurantTitle: String, restaurantLink: String, inApp: Bool) {
        GATraker.shared.openRestaurantWebSite(eventTitle: GAEventsTitle.openRestaurantWebSite.rawValue, restaurantTitle: restaurantTitle, restaurantLink: restaurantLink, inApp: inApp)
    }
    
}
