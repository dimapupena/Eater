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
        self.updateUserRestaurants()
    }
    
    static func updateUserRestaurants() {
        guard let restaurants = ConfigManager.sharer.appConfiguration?.restaurants else { return }
        let realm = try! Realm()
        let realmRestraunts = self.getRestrauntsFromRealm()
        for item in restaurants {
            if !realmRestraunts.contains(where: {$0.name == item.name}) {
                do {
                    try realm.write({
                        try? realm.add(RealmUserFavouritePlaces(data: item))
                        print("wrote")
                    })
                    try? realm.commitWrite()
                } catch  {
                    print("error")
                }

            }
        }
    }
    
    static func getRestrauntsFromRealm() -> [RealmUserFavouritePlaces] {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!.path)
        let realmRestraunts = Array(realm.objects(RealmUserFavouritePlaces.self))
        return realmRestraunts
    }
}

