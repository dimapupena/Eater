//
//  LoaderView.swift
//  Eater
//
//  Created by Dmytro Pupena on 21.05.2021.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    private var loaderView: UIActivityIndicatorView = {
        let loaderView = UIActivityIndicatorView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        return loaderView
    }()
    
    private var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#d0f7f7")
        view.alpha = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupCustomViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomViews(){
        setupBackgroundView()
        setupLoader()
    }
    
    private func setupBackgroundView() {
        self.addSubview(backgroundView)
        
        backgroundView.setZeroConstraits(with: self)
    }
    
    private func setupLoader() {
        self.addSubview(loaderView)
        
        loaderView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        loaderView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loaderView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loaderView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func startAnimation() {
        loaderView.startAnimating()
    }
}
