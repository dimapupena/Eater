//
//  GATexts.swift
//  Eater
//
//  Created by Dmitriy Pupena on 17.05.2021.
//

import Foundation

enum GAEventsTitle: String {
    case openScreen                = "openScreen"
    case openRestaurantWebSite     = "openRestaurantWebSite"
    case markRestaurantAsLoved     = "markRestaurantAsLoved"
    case getDirectionToRestaurant  = "directionToRestaurant"
}

enum GAOpenScreenTitles: String {
    case headViewController     = "HeadScreen"
    case restaurantVC           = "RestaurantList"
    case restaurantWebView      = "RestaurantWebSite"
    case userLovedRestaurantVC  = "UserLovedRestaurantList"
    case settingsVC             = "SettingsScreen"
    case importantInformationVC = "ImportantInformationScreen"
}
