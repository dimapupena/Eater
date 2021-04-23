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
        vc.userInformationAction = { [weak self] in
            self?.makeInformationVC(info: UserUsefulInformation(title: "some title", description: "some description"))
        }
        router.pushViewController(vc, animated: true)
    }
    
    func makeInformationVC(info: UserUsefulInformation) {
        let informationVC = factory.makeImportantinformationVC(userInformation: info)
        informationVC.backButtonAction = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        router.pushViewController(informationVC, animated: true)
    }
    
    func makeHomeFlow() {
        let homeCo = factory.makeHomeCoordinator(router: router, factory: HomeCoordinatorFactory())
        self.addChild(homeCo)
        homeCo.start()
    }
}
