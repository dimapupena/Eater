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
        vc.openWebViewItem = { [weak self] in
            self?.makeReastaurantWebView()
        }
        router.pushViewController(vc, animated: true)
    }
    
    func makeReastaurantWebView() {
        let webVC = self.factory.makeRestaurantWebVC()
        webVC.onFinish = { 
            self.router.popViewController(animated: true)
        }
        self.router.pushViewController(webVC, animated: true)
    }
}
