//
//  RestaurantContent.swift
//  Eater
//
//  Created by Dmitriy Pupena on 23.03.2021.
//

import Foundation
import UIKit

struct AppConfiguration: Decodable {
    let restaurants : [RestaurantContent]
}

struct RestaurantContent: Decodable {
    let name        : String
    let discription : String
    let sheff       : String
    let photo       : String
    let hearePhoto  : String
    let adress      : String
    let rating      : String
    let url         : String
}
