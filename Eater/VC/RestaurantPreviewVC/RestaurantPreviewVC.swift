//
//  RestaurantPreviewVC.swift
//  Eater
//
//  Created by Dmytro Pupena on 25.10.2021.
//

import Foundation
import UIKit

class RestaurantPreviewVC: UIViewController {
    
    let previewView: RestaurantPreviewView = {
        let view = RestaurantPreviewView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        setupPreviewView()
    }
    
    func setupPreviewView() {
        view.addSubview(previewView)
        
        view.setZeroConstraits(with: previewView)
    }
    
}
