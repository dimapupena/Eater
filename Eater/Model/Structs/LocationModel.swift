//
//  LocationModel.swift
//  Eater
//
//  Created by Dmitriy Pupena on 07.05.2021.
//

import Foundation
import UIKit
import CoreLocation

struct LocationModel {
    let latitude: Double
    let longitude: Double
    let date: Date?
    let dateString: String?
    let description: String? = nil
    
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.date = Date()
        self.dateString = ""
    }
    
    init(latitude: Double?, longitude: Double?) {
        self.latitude = latitude ?? 0.0
        self.longitude = longitude ?? 0.0
        self.date = Date()
        self.dateString = ""
    }
}
