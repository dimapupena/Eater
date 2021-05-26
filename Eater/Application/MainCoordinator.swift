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
    func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(userLoggedOutNotification), name: .userLoggedOut, object: nil)
    }
    
    private func makeSplashVC() {
        let vc = factory.makeSplashVC()
        // should be weak self
        vc.onFinish = { success in
            self.startMainFlow(success)
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func startMainFlow(_ successLoaded: Bool = true) {
        if UserManager.sharedInstance.isUserLoggedIn() {
            makeHeadVC()
        } else {
            makeLoginVC()
        }
    }
    
    private func makeLoginVC() {
        let vc = factory.makeLoginVC()
        vc.userLoggedInAction = { [weak self] in
            self?.makeHeadVC()
        }
        vc.signUpAction = { [weak self] in
            self?.makeSignUpVC()
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func makeHeadVC() {
        let vc = factory.makeHeadVC()
        vc.onButtonClick = { [weak self] in
            self?.makeHomeFlow()
        }
        vc.settingsButtonAction = { [weak self] in
            self?.makeSettingsVC()
        }
        vc.userInformationAction = { [weak self] in
            self?.makeInformationVC(info: UserUsefulInformation(title: "some title", description: "some description"))
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func makeSignUpVC() {
        let vc = factory.makeSignUpVC()
        vc.backButtonAction = {[weak self] in
            self?.router.popViewController(animated: true)
        }
        vc.userLoggedUpAction = { [weak self] success in
            self?.startMainFlow()
        }
        router.pushViewController(vc, animated: true)
    }
    
    private func makeInformationVC(info: UserUsefulInformation) {
        let informationVC = factory.makeImportantinformationVC(userInformation: info)
        informationVC.backButtonAction = { [weak self] in
            self?.router.popViewController(animated: true)
        }
        router.pushViewController(informationVC, animated: true)
    }
    
    private func makeSettingsVC() {
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
        settingsVC.userDeleteAction = { [weak self] in
            self?.startMainFlow()
        }
        router.pushViewController(settingsVC, animated: true)
    }
    
    private func makeHomeFlow() {
        let homeCo = factory.makeHomeCoordinator(router: router, factory: HomeCoordinatorFactory())
        self.addChild(homeCo)
        homeCo.start()
    }
    
    private func performLogOut() {
        RealmHelper.deleteRealmData { _ in
            UserManager.sharedInstance.signOutUser { [weak self] success in
                if success {
                    self?.makeLoginVC()
                }
            }
        }
    }
    
    @objc private func userLoggedOutNotification() {
        self.startMainFlow()
    }
}
