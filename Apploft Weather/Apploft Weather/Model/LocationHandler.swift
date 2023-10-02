//
//  LocationHandler.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 05.04.23.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private var locationManager = CLLocationManager()
    
    @Published var coordinates: (Double, Double)?
    @Published var foundLocation = false
    @Published var errorFound = false
    
    override init() {
         super.init()
         locationManager.delegate = self
         locationManager.requestWhenInUseAuthorization()
      }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            print("Successfully authorized")
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()

        } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            print("Error: Location access denied.")
            print(locationManager.authorizationStatus.rawValue)
            errorFound = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("why is this showing?")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("updated location")
        guard let currentLocation = locations.first else {
            print("Error: Unable to get current location.")
            return
        }
        print(currentLocation)
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        coordinates = (latitude, longitude)
        foundLocation = true
        errorFound = false
        locationManager.stopUpdatingLocation()
    }
    
}
