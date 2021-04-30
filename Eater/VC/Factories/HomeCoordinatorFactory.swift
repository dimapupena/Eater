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
    
    func makeRestaurantWebVC(_ link: String?) -> RestaurantWebView {
        let webView = RestaurantWebView()
        webView.setupView(link ?? "https://www.google.com")
        return webView
    }
    
    
    func makeUserLovedRestaurantVC() -> UserLovedRestaurantVC {
        return UserLovedRestaurantVC()
    }
}
