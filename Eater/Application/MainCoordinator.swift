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
        startInitialFlow()
        makeLoginVC()
    }
    
    func startInitialFlow() {
        DispatchQueue.main.async {
            ConfigManager.sharer.loadData()
            RealmHelper.updateRealmData()
        }
    }
    
    func makeLoginVC() {
        let vc = factory.makeLoginVC()
        // closure  has to be weak self
        vc.userLoggedInAction = {
            self.makeHeadVC()
        }
        router.pushViewController(vc, animated: true)
    }
    
    func makeHeadVC() {
        let vc = factory.makeHeadVC()
        // closure  has to be weak self
        vc.onButtonClick = {
            self.makeHomeFlow()
        }
        vc.settingsButtonAction = { [weak self] in
            self?.makeSettingsVC()
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
    
    func makeSettingsVC() {
        let informationVC = factory.makeSettingsVC()
        informationVC.backButtonAction = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        informationVC.changeBackgroundAction = { [weak self, weak informationVC] in
            guard let backgroundVC = self?.factory.makeBackgroundAppVC() else { return }
            informationVC?.present(backgroundVC, animated: true, completion: nil)
        }
        router.pushViewController(informationVC, animated: true)
    }
    
    func makeHomeFlow() {
        let homeCo = factory.makeHomeCoordinator(router: router, factory: HomeCoordinatorFactory())
        self.addChild(homeCo)
        homeCo.start()
    }
}
