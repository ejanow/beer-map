//
//  BeerMapViewController.swift
//  janowski-assignment4
//
//  Created by e on 5/20/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class BeerMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!    
    
    var breweries: [Brewery]?
    var locationManager: CurrentLocationManager?
    var currentLocation: CLLocation?
    
    func handleIncoming(breweries b: [Brewery]) {
        DispatchQueue.main.async {
            self.removeBreweriesFromMap()
            self.breweries = b
            self.mapView.addAnnotations(b)
        }
    }
    
    private func removeBreweriesFromMap() {
        self.mapView.removeAnnotations(self.mapView.annotations)
    }
    
    func setCurrent(location l: CLLocation) {
        self.currentLocation = l
        let region = MKCoordinateRegionMakeWithDistance(l.coordinate, 2000, 2000)
        self.mapView.setRegion(region, animated: true)
    }
    
    private func start() {
        self.locationManager = CurrentLocationManager(self)
        self.mapView.showsUserLocation = true
        self.mapView.mapType = .standard
        self.mapView.isZoomEnabled = true
        self.mapView.isScrollEnabled = true
    }
    
    private func end() {
        self.locationManager = nil
    }
    
    // Mark: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.end()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.removeBreweriesFromMap()
        self.breweries = nil
        self.end()
    }
}
