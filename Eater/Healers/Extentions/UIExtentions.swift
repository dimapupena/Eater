//
//  UIExtentions.swift
//  Eater
//
//  Created by Dmitriy Pupena on 25.02.2021.
//

import Foundation
import UIKit

extension UIView {
    func setZeroConstraits(with parentView : UIView) {
        if !self.translatesAutoresizingMaskIntoConstraints {
            self.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        }
    }
    func setSafeZeroConstraits(with parentView : UIView) {
        if !self.translatesAutoresizingMaskIntoConstraints {
            self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor).isActive = true
        }
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        let imageURL = url
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            guard error == nil else { print("ERROR: with downloading image"); return }
            
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else { return }
                if let receivedData = data {
                    DispatchQueue.main.async {
                        print("success")
                        self.image = UIImage(data: receivedData)
                    }
                }
            }
        }
        task.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size:targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        var hex = hexString.hasPrefix("#") ? String(hexString.dropFirst()) : hexString
        
        guard hex.count == 3 || hex.count == 6 else {
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
            return
        }
        
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        let number = Int(hex, radix: 16)!
        let red = CGFloat((number >> 16) & 0xFF) / 255.0
        let green = CGFloat((number >> 8) & 0xFF) / 255.0
        let blue = CGFloat(number & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    // Setup custom colours we can use throughout the app using hex values
    static let seemuBlue = UIColor(hex: 0x00adf7)
    static let youtubeRed = UIColor(hex: 0xf80000)
    static let transparentBlack = UIColor(hex: 0x000000, a: 0.5)
    
    // Create a UIColor from RGB
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    
    // Create a UIColor from a hex value (E.g 0x000000)
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    
}


extension UIViewController {
    func showLoaderView() {
        DispatchQueue.main.async {
            if self.view.subviews.filter({return $0 as? LoaderView != nil }).count == 0 {
                self.setupLoaderVC()
            }
        }
    }
    
    private func setupLoaderVC() {
        let view = LoaderView()
        self.view.addSubview(view)
        view.setZeroConstraits(with: self.view)
    }
    
    func hideLoaderView() {
        DispatchQueue.main.async {
            let loaders = self.view.subviews.filter{$0 is LoaderView}
            loaders.forEach { (vc) in
                vc.removeFromSuperview()
            }
        }
    }
}
