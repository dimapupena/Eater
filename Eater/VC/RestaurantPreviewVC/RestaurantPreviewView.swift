//
//  RestaurantPreviewView.swift
//  Eater
//
//  Created by Dmytro Pupena on 25.10.2021.
//

import Foundation
import UIKit
import AVFoundation

class PlayerView: UIView {

    override static var layerClass: AnyClass { AVPlayerLayer.self }
    
    var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}

class RestaurantPreviewView: UIView {
    
    let playerView: PlayerView = {
        let view = PlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        setupViews()
    }
    
    func setupViews() {
        setupPlayerLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlayerLayer() {
        addSubview(playerView)
        
        playerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        playerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        playerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        playerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
}
