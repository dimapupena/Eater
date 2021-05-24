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
        makeSplashVC()
    }
    
    func makeSplashVC() {
        let vc = factory.makeSplashVC()
        // should be weak self
        vc.onFinish = { success in
            self.startMainFlow(success)
        }
        router.pushViewController(vc, animated: true)
    }
    
    func startMainFlow(_ successLoaded: Bool) {
        if UserManager.sharedInstance.isUserLoggedIn() {
            makeHeadVC()
        } else {
            makeLoginVC()
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
        let settingsVC = factory.makeSettingsVC()
        settingsVC.backButtonAction = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        settingsVC.changeBackgroundAction = { [weak self, weak settingsVC] in
            guard let backgroundVC = self?.factory.makeBackgroundAppVC() else { return }
            backgroundVC.onFinish = { [weak self] in
                settingsVC?.dismiss(animated: true, completion: nil)
                self?.router.popViewController(animated: true)
            }
            settingsVC?.present(backgroundVC, animated: true, completion: nil)
        }
        settingsVC.logOutAction = { [weak self] in
            self?.performLogOut()
        }
        router.pushViewController(settingsVC, animated: true)
    }
    
    func makeHomeFlow() {
        let homeCo = factory.makeHomeCoordinator(router: router, factory: HomeCoordinatorFactory())
        self.addChild(homeCo)
        homeCo.start()
    }
    
    private func performLogOut() {
        UserManager.sharedInstance.signOutUser { [weak self] success in
            if success {
                self?.makeLoginVC()
            }
        }
    }
}
