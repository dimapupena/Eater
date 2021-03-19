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
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
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
    static let iqosBlack = UIColor(red: 39, green: 42, blue: 51)
    static let iqosRed = UIColor(red: 229, green: 82, blue: 82)
    static let iqosGray = UIColor(red: 115, green: 117, blue: 124)
    static let iqosLightGray = UIColor(hex: 0xe8e8e8)
    static let iqosGold = UIColor(red: 243, green: 237, blue: 232)
    
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
