//
//  LocationManager.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationManagerError: Error {
    case permissionDenied
}

protocol LocationManagerHandler{
    func getCurentLocation(completionHandler: @escaping (Result<CLLocation>) -> Void)
}

class LocationManager: NSObject, LocationManagerHandler {
    private let locationManager = CLLocationManager()
    private var wasNotDetermined: Bool = false
    private var completionHandler: ((Result<CLLocation>) -> Void)?
    
    private var status: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    override init( ){
        super.init()
        wasNotDetermined = status == .notDetermined
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
    
    func getCurentLocation(completionHandler: @escaping (Result<CLLocation>) -> Void) {
        guard status != .denied, status != .restricted, CLLocationManager.locationServicesEnabled() else {
            completionHandler(.failure(LocationManagerError.permissionDenied))
            return
        }
        
        self.completionHandler = completionHandler
        status == .notDetermined ? locationManager.requestWhenInUseAuthorization() : locationManager.startUpdatingLocation()
    }
}


//MARK :- CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        completionHandler?(.success(location))
        completionHandler = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard wasNotDetermined, status != .notDetermined else { return }
        wasNotDetermined = false
        if status == .denied || status == .restricted {
            completionHandler?(.failure(LocationManagerError.permissionDenied))
            completionHandler = nil
        } else {
            locationManager.startUpdatingLocation()
        }
    }
}
