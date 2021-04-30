//
//  MainFlowCoordinator.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.03.2021.
//

import Foundation
import UIKit

class HomeCoordinator : BaseCoordinator {
    private let factory: HomeCoordinatorFactory
    
    init(router: UINavigationController, factory: HomeCoordinatorFactory) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        let vc = factory.makeRestaurantVC()
        vc.backButtonAction = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        vc.openUserLoved = { [weak self] in
            self?.openUserLovedPlaces()
        }
        vc.openWebViewItem = { [weak self] link in
            self?.makeRestaurantWebView(link)
        }
        router.pushViewController(vc, animated: true)
    }
    
    func openUserLovedPlaces() {
        let lovedVC = factory.makeUserLovedRestaurantVC()
        lovedVC.backButtonAction = {[weak self] in
            self?.router.popViewController(animated: true)
        }
        lovedVC.openWebViewItem = {[weak self] link in
            self?.makeRestaurantWebView(link)
        }
        router.pushViewController(lovedVC, animated: true)
    }
    
    func makeRestaurantWebView(_ link: String?) {
        let webVC = self.factory.makeRestaurantWebVC(link)
        webVC.onFinish = { 
            self.router.popViewController(animated: true)
        }
        self.router.pushViewController(webVC, animated: true)
    }
}
