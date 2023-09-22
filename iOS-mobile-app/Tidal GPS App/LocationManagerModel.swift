//
//  Location_Manager.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/7/23.
//

import Foundation
import CoreLocation

class LocationManagerModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLLocation?
    
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        
        //precise location only available on iOS 14 and over, also is in user settings so must create handling for various states. Add a banner telling user to turn on precise location.
        if #available(iOS 14.0, *) {
            switch locationManager.accuracyAuthorization {
            case .fullAccuracy:
                locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
                print("Full Accuracy")
            case .reducedAccuracy:
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                print("Reduced Accuracy")
            @unknown default:
                print("Unknown Precise Location...")
                        }
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        locationManager.distanceFilter = 0.4
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
}
