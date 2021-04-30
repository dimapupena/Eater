//
//  RestaurantManager.swift
//  Eater
//
//  Created by Dmitriy Pupena on 26.04.2021.
//

import Foundation
import Realm
import RealmSwift

class RestaurantManager {
    
    static var shared: RestaurantManager = RestaurantManager()
    
    func updateUserRestaurants() {
        guard let restaurants = ConfigManager.sharer.appConfiguration?.restaurants else { return }
        let realm = try! Realm()
        let realmRestraunts = self.getRestrauntsFromRealm()
        for item in restaurants {
            if !realmRestraunts.contains(where: {$0.name == item.name}) {
                do {
                    try realm.write({
                        try? realm.add(RealmRestaurants(data: item))
                        print("wrote")
                    })
                    try? realm.commitWrite()
                } catch  {
                    print("error")
                }

            }
        }
    }
    
    func getRestrauntsFromRealm() -> [RealmRestaurants] {
        guard let realm = try? Realm() else { return [RealmRestaurants]() }
        print(Realm.Configuration.defaultConfiguration.fileURL!.path)
        let realmRestraunts = Array(realm.objects(RealmRestaurants.self))
        return realmRestraunts
    }
    
    func getRestaurantFromRealm(restaurantName: String) -> RealmRestaurants? {
        guard let realm = try? Realm() else {return RealmRestaurants()}
        let realmRestaurant = realm.objects(RealmRestaurants.self).first { (item) -> Bool in
            item.name == restaurantName
        }
        return realmRestaurant
    }
    
    func getLovedRestaurantFromRealm() -> [RealmRestaurants]? {
        guard let realm = try? Realm() else {return nil}
        var realmElements = [RealmRestaurants]()
        for element in realm.objects(RealmRestaurants.self) {
            if element.isFavourite {
                realmElements.append(element)
            }
        }
        return realmElements
    }
    
    func updateFavouriteStatus(to newStatus: Bool, restaurantName: String) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            let realmRestaurant = realm.objects(RealmRestaurants.self).first { (item) -> Bool in
                item.name == restaurantName
            }
            realmRestaurant?.isFavourite = newStatus
            try realm.commitWrite()
        } catch  {
            print("error")
        }
    }
}
