//
//  LocationManager.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 8.07.2022.
//

import Foundation
import CoreLocation

class LocationController: NSObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager!
    var locationDidChanged: ((Coordinate?)->())?
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    

    
    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        let status: CLAuthorizationStatus = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            break
        case .restricted:
            manager.startUpdatingLocation()
        case .denied:
            break
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .authorized:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
        
    }
    
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways{
            if let location = locations.first{
                locationDidChanged?(Coordinate(longitude: Double(round(1000000 * location.coordinate.longitude) / 1000000), latitude: Double(round(1000000 * location.coordinate.latitude) / 1000000)))
            }
        }
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error")
        print(error)
    }
    
}
