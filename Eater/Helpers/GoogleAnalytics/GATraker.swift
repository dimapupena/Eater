//
//  GATraker.swift
//  Eater
//
//  Created by Dmitriy Pupena on 17.05.2021.
//

import Foundation
import Firebase

class GATraker {
    
    static let shared: GATraker = GATraker()
    
    func openScreenEvent(eventTitle: String, screenTitle: String) {
        let eventInstance = OpenScreenEvent(screenTitle: screenTitle)
        submitEvent(eventTitle: eventTitle, parameters: eventInstance.getGAParameters())
    }
    
    func openRestaurantWebSite(eventTitle: String, restaurantTitle: String, restaurantLink: String, inApp: Bool) {
        let eventInstance = openRestaurantEvent(restaurantTitle: restaurantTitle, restaurantLink: restaurantLink, inApp: inApp)
        submitEvent(eventTitle: eventTitle, parameters: eventInstance.getGAParameters())
    }
    
    func markAsUserLoved(eventTitle: String, restaurantTitle: String, restaurantLink: String, restaurantRating: Double?, isLoved: Bool) {
        let eventInstance = MarkUserLovedEvent(restaurantTitle: restaurantTitle, restaurantLink: restaurantLink, restaurantRating: restaurantRating, isLoved: isLoved)
        submitEvent(eventTitle: eventTitle, parameters: eventInstance.getGAParameters())
    }
    
    func getDirectionToRestaurant(eventTitle: String, restaurantTitle: String, restaurantLatitude: Double?, restaurantLongitude: Double?) {
        let eventInstance = GetDirectionEvent(restaurantTitle: restaurantTitle, restaurantLatitude: restaurantLatitude, restaurantLongitude: restaurantLongitude)
        submitEvent(eventTitle: eventTitle, parameters: eventInstance.getGAParameters())
    }
    
    func submitEvent(eventTitle: String, parameters: [String : Any]) {
        Analytics.logEvent(eventTitle, parameters: parameters)
    }
    
    struct OpenScreenEvent {
        let screenTitle: String
        
        init(screenTitle: String) {
            self.screenTitle = screenTitle
        }
        
        func getGAParameters() -> [String : Any] {
            let parameters: [String : Any] = ["screenTitle" : screenTitle]
            return parameters
        }
    }
    
    struct openRestaurantEvent {
        let restaurantTitle : String
        let restaurantLink  : String
        let inApp           : Bool
        
        init(restaurantTitle: String, restaurantLink: String, inApp: Bool) {
            self.restaurantTitle = restaurantTitle
            self.restaurantLink  = restaurantLink
            self.inApp           = inApp
        }
        
        func getGAParameters() -> [String : Any] {
            let parameters: [String : Any] = ["restaurantTitle" : restaurantTitle,
                                              "restaurantLink"  : restaurantLink,
                                              "inApp"           : inApp]
            return parameters
        }
    }
    
    struct MarkUserLovedEvent {
        let restaurantTitle  : String
        let restaurantLink   : String
        let restaurantRating : Double?
        let isLoved          : Bool
        
        init(restaurantTitle: String, restaurantLink: String, restaurantRating: Double?, isLoved: Bool) {
            self.restaurantTitle  = restaurantTitle
            self.restaurantLink   = restaurantLink
            self.restaurantRating = restaurantRating
            self.isLoved          = isLoved
        }
        
        func getGAParameters() -> [String : Any] {
            let parameters: [String : Any] = ["restaurantTitle"  : restaurantTitle,
                                              "restaurantLink"   : restaurantLink,
                                              "restaurantRating" : restaurantRating ?? "No information",
                                              "isLoved"          : isLoved]
            return parameters
        }
    }
    
    struct GetDirectionEvent {
        let restaurantTitle     : String
        let restaurantLatitude  : Double?
        let restaurantLongitude : Double?
        
        init(restaurantTitle: String, restaurantLatitude: Double?, restaurantLongitude: Double?) {
            self.restaurantTitle     = restaurantTitle
            self.restaurantLatitude  = restaurantLatitude
            self.restaurantLongitude = restaurantLongitude
        }
        
        func getGAParameters() -> [String : Any] {
            let parameters: [String : Any] = ["restaurantTitle"     : restaurantTitle,
                                              "restaurantLatitude"  : restaurantLatitude ?? "No information",
                                              "restaurantLongitude" : restaurantLongitude ?? "No information"]
            return parameters
        }
    }
    
}
