//
//  SplashVC.swift
//  Eater
//
//  Created by Dmytro Pupena on 24.05.2021.
//

import Foundation
import UIKit

class SplashVC: UIViewController {
    
    var onFinish: ((Bool) -> Void)?
    
    override func viewDidLoad() {
//        self.view.backgroundColor = UIColor(hexString: "#d77feb")
        self.view.backgroundColor = UIColor.red
        downloadData()
    }
    
    func downloadData() {
        RealmHelper.updateRealmData()
        ConfigManager.sharer.loadData { [weak self] success in
            self?.onFinish?(success)
        }
    }
    
}
