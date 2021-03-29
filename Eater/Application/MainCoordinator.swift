//
//  MainCoordinator.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit
 
class MainCoordinator: BaseCoordinator {
    private let factory: MainCoordinatorFactory
    
    init(router: UINavigationController, factory: MainCoordinatorFactory) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        ConfigManager.sharer.loadData()
        let vc = factory.makeHeadVC()
        vc.onButtonClick = {
            self.makeHomeFlow()
        }
        router.pushViewController(vc, animated: true)
    }
    
    func makeHomeFlow() {
        let homeCo = factory.makeHomeCoordinator(router: router, factory: HomeCoordinatorFactory())
        self.addChild(homeCo)
        homeCo.start()
    }
}
