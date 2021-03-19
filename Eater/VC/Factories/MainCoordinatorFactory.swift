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
    
    func makeHomeCoordinator(router: UINavigationController, factory: HomeCoordinatorFactory) -> HomeCoordinator {
        return HomeCoordinator(router: router, factory: factory)
    }
    
}
