//
//  Brewery.swift
//  janowski-assignment4
//
//  Created by e on 5/19/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import CoreLocation.CLLocation
import MapKit.MKAnnotation

class Brewery: NSObject, MKAnnotation {
    
    let id: String
    let name: String
    let streetAddress: String
    let locality: String
    let region: String
    let location: CLLocation
    let website: String
    
    // MKAnnotation Properties
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(id: String, name: String, streetAddress: String, locality: String,
         region: String, location: CLLocation, website: String) {
        self.id = id
        self.name = name
        self.streetAddress = streetAddress
        self.locality = locality
        self.region = region
        self.location = location
        self.website = website
        
        self.coordinate = location.coordinate
        self.title = name
        self.subtitle = "\(streetAddress) \(locality), \(region)"
    }    
}

let testBrewery: Brewery = Brewery(
    id: "w8FpFj",
    name: "name",
    streetAddress: "streetAddress",
    locality: "locality",
    region: "region",
    location: CLLocation(latitude: 1, longitude: 1),
    website: "website"
)
