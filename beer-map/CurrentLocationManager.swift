//
//  CurrentLocationManager.swift
//  janowski-assignment4
//
//  Created by e on 5/20/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    unowned let beerMap: BeerMapViewController
    
    var currentLocation: CLLocation?
    
    
    init(_ bm: BeerMapViewController) {
        self.beerMap = bm
        super.init()
        
        if self.checkLocationAccess() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    deinit {
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.beerMap.setCurrent(location: location)
        
        self.callApi(for: location)
        
        if self.currentLocation == nil {
            // First call.
            self.currentLocation = location
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil // Hard reset
            self.locationManager.delegate = self
            self.locationManager.startMonitoringSignificantLocationChanges()
        }
 
        Utils.logDebug(["Location Updated", location])
        self.currentLocation = location
    }
    
    private func callApi(for location: CLLocation) {
        Utils.logDebug("Calling API!")
        DispatchQueue.global(qos: .userInteractive).async {
            BreweryService.getBreweriesFrom(location: location) { breweries in
                self.beerMap.handleIncoming(breweries: breweries)
            }
        }
    }
    
    private func checkLocationAccess() -> Bool {
        
        locationManager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else {
            Utils.presentError(message: "Location services are disabled on your device. In order to use this app, go to " +
                "Settings → Privacy → Location Services and turn location services on.", for: self.beerMap)
            return false
        }
        
        let authStatus = CLLocationManager.authorizationStatus()
        guard authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways else {
            switch authStatus {
            case .denied, .restricted:
                Utils.presentError(message: "This app is not authorized to use your location. In order to use this app, " +
                    "go to Settings → BrewerySearch → Location and select the \"While Using " +
                    "the App\" setting.", for: self.beerMap)
                return false
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                return true
                
            default:
                Utils.logError("Error checking geolocation conditions")
                return false
            }
        }
        
        return true
    }
}

