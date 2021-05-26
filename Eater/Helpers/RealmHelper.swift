//
//  RealmHelper.swift
//  Eater
//
//  Created by Dmitriy Pupena on 26.04.2021.
//

import Foundation
import Realm
import RealmSwift

class RealmHelper {
    
    static func updateRealmData() {
        RestaurantManager.shared.updateUserRestaurants()
    }
    
    static func deleteRealmData(completion: ((Bool) -> Void)) {
        RestaurantManager.shared.deleteRestaurantData(completion: completion)
        ConfigManager.sharer.dataWasSynchronized = false
    }
    
}

