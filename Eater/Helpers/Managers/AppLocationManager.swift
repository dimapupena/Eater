//
//  AppLocationManager.swift
//  Eater
//
//  Created by Dmitriy Pupena on 07.05.2021.
//

import Foundation
import CoreLocation
import UserNotifications

class AppLocationManager: NSObject {
    
    static let shared: AppLocationManager = AppLocationManager()
    private var locationManager: CLLocationManager = CLLocationManager()
    
    var currentLocation: LocationModel?
    
    func initalLocationFlow() {
//        let center = UNUserNotificationCenter.current()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startMonitoringVisits()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }
    
}

extension AppLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                self.currentLocation = LocationModel(location: location)
                print("longitude: \(location.coordinate.longitude), latitude: \(location.coordinate.latitude)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("get location process was faild, error: \(error)")
    }
}
