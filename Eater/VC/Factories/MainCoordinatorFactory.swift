//
//  MainCoordinatorFactory.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit

class MainCoordinatorFactory {
    
    func makeHeadVC() -> HeadViewController {
        return HeadViewController()
    }
    
    func makeSettingsVC() -> SettingsViewController {
        return SettingsViewController()
    }
    
    func makeBackgroundAppVC() -> BackgroundAppVC {
        return BackgroundAppVC()
    }
    
    func makeImportantinformationVC(userInformation: UserUsefulInformation) -> ImportantInformationVC {
        return ImportantInformationVC(importantInformation: userInformation)
    }
    
    func makeHomeCoordinator(router: UINavigationController, factory: HomeCoordinatorFactory) -> HomeCoordinator {
        return HomeCoordinator(router: router, factory: factory)
    }
    
    func makeLoginVC() -> LoginVC {
        return LoginVC()
    }
    
    func makeSignUpVC() -> SignUpVC {
        return SignUpVC()
    }
    
    func makeSplashVC() -> SplashVC {
        return SplashVC()
    }
    
}
