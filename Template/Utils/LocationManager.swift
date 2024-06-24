//
//  LocationManager.swift
//  Template
//
//  Created by Anthony Pham on 6/23/24.
//

import CoreLocation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager

    @Published var location: CLLocation? = nil
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }
}
