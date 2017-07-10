//
//  BreweryService.swift
//  janowski-assignment4
//
//  Created by e on 5/19/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreLocation.CLLocation

public struct BreweryService {
    
    static func getBreweriesFrom(location: CLLocation, completion: @escaping ([Brewery]) -> Void ) {
        
        let url: String = "https://rocky-river-43967.herokuapp.com/api/breweries"
        
        let lng = location.coordinate.longitude
        let lat = location.coordinate.latitude
        
        let params = ["lng": lng, "lat": lat]
        
        Alamofire.request(url, parameters: params).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let breweries = BreweryFactory.parseJson(json: json)
                completion(breweries)
                
            case .failure(let error):
                Utils.logError(["Error calling API in Brewery Service!", error])
                completion([Brewery]())
                return
            }
        }
    }
}
