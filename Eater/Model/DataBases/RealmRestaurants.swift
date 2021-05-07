//
//  RealmUserFavouritePlaces.swift
//  Eater
//
//  Created by Dmitriy Pupena on 26.04.2021.
//

import Foundation
import Realm
import RealmSwift

class RealmRestaurants: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var placeDescription: String?
    @objc dynamic var sheff: String?
    @objc dynamic var logoPhotoUrl: String?
    @objc dynamic var mainPhotoUrl: String?
    @objc dynamic var address: String?
    @objc dynamic var rating: String?
    @objc dynamic var restrauntUrl: String?
    var latitude = RealmOptional<Double>()
    var longitude = RealmOptional<Double>()
    @objc dynamic var isFavourite: Bool = false
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(data: RestaurantContent) {
        self.init()
        self.name = data.name
        self.placeDescription = data.description
        self.sheff = data.sheff
        self.logoPhotoUrl = data.photo
        self.mainPhotoUrl = data.hearePhoto
        self.address = data.address
        self.rating = data.rating
        self.restrauntUrl = data.url
        self.latitude.value = data.latitude
        self.longitude.value = data.longitude
        self.isFavourite = data.isFavourite ?? false
    }
}
