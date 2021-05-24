//
//  LoaderView.swift
//  Eater
//
//  Created by Dmytro Pupena on 21.05.2021.
//

import Foundation
import UIKit

class CustomLoaderView: UIView {
    
    private var loaderView: UIActivityIndicatorView!
    private var backgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCustomViews()
    }
    
    private func setupCustomViews(){
        setupLoader()
        setupBackgroundView()
    }
    
    private func setupLoader() {
        
    }
    
    private func setupBackgroundView() {
        
    }
}
