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
    let description : String
    let sheff       : String
    let photo       : String
    let hearePhoto  : String
    let address      : String
    let rating      : String
    let url         : String
}
