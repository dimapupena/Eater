//
//  HomeFactory.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation

class HomeCoordinatorFactory {
    
    func makeRestaurantVC() -> RestaurantVC {
        return RestaurantVC()
    }
    
    func makeRestaurantWebVC() -> ReastaurantWebView {
        return ReastaurantWebView()
    }
    
}
