//
//  BreweryFactory.swift
//  janowski-assignment4
//
//  Created by e on 5/19/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

public struct BreweryFactory {
    
    static func parseJson(json: JSON) -> [Brewery] {
        var breweries = [Brewery]()
        
        for j in json["data"].arrayValue {
            if let brewery = self.makeFromJsonObject(j) {
                breweries.append(brewery)
            }
        }
        
        return breweries
    }
    
    private static func makeFromJsonObject(_ j: JSON) -> Brewery? {
        
        guard let id: String = j["brewery"]["id"].string
            else {
                Utils.logError("error getting brewery ID")
                return nil
        }
        
        guard let name: String = j["brewery"]["name"].string
            else {
                Utils.logError("error getting brewery name")
                return nil
        }
        
        guard let streetAddress: String = j["streetAddress"].string
            else {
                //Utils.logError("Error getting Street Address of Brewery") 
                // This error is usually from bad data. not bad parsing. Silencing it
                return nil
        }
        
        guard let locality: String = j["locality"].string
            else {
                Utils.logError("Error getting Brewery Locality")
                return nil
        }
        
        guard let region: String = j["region"].string
            else {
                Utils.logError("Error Getting Brewery Region")
                return nil
        }
        
        guard let lat: Double = j["latitude"].double
            else {
                Utils.logError("Error getting Brewery Lat")
                return nil
        }
        
        guard let lng: Double = j["longitude"].double
            else {
                Utils.logError("Error getting Brewery Lng")
                return nil
        }
        
        let website = j["website"].string ?? ""
        
        let location = CLLocation(latitude: lat, longitude: lng)
        
        return Brewery(id: id, name: name,
                       streetAddress: streetAddress,
                       locality: locality, region: region,
                       location: location, website: website)
    
    }
    
    
}
