//
//  File.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var router: UINavigationController
    
    func start() {
         
    }
    init(router : UINavigationController) {
        self.router = router
    }
    
    func addChild(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: {$0 === coordinator}) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChild(_ coordinator: Coordinator?) {
        guard !childCoordinators.isEmpty, let coordinator = coordinator else {
            return
        }
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter({$0 !== coordinator}).forEach({coordinator.removeChild($0)})
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func removeAllChildren(){
        guard !childCoordinators.isEmpty else {
            return
        }
        childCoordinators = []
    }
    
    
}
