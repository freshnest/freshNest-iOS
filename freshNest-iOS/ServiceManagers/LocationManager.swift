//
//  LocationManager.swift
//  freshNest-iOS
//
//  Created by Nitin Kumar on 13/06/24.
//

import SwiftUI
import CoreLocation

class LocationManagerDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManagerDelegate()
    
    var locationManager = CLLocationManager()
    @Published var location: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Location authorization status is not determined.")
        case .restricted:
            print("Location authorization status is restricted.")
        case .denied:
            print("Location authorization status is denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location authorization status is authorized.")
            locationManager.requestLocation()
        @unknown default:
            print("Unknown location authorization status.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}
