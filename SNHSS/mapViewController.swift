//
//  mapViewController.swift
//  SNHSS
//
//  Created by dlabbe on 9/4/17.
//  Copyright © 2017 Southern NH Snow Slickers. All rights reserved.
//
import CoreLocation
import UIKit
import MapKit



var locationManager = CLLocationManager()
class mapViewController: UIViewController {
    
    @IBOutlet weak var mapPageTitle: UINavigationBar!
    @IBOutlet weak var mapTypeTitle: UIBarButtonItem!
    @IBOutlet weak var mapPage: MKMapView!
  
    let places = Place.getPlaces()
    var regionRadius: CLLocationDistance = 20000

    @IBAction func locateMe(_ sender: UIBarButtonItem) {
        let userLocation = mapPage.userLocation
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, regionRadius, regionRadius)
        mapPage.setRegion(region, animated: true)
    }
    
    @IBAction func setMapType(_ sender: UIBarButtonItem) {
        if mapPage.mapType == MKMapType.standard{
            mapTypeTitle.title = "Standard"
            mapPage.mapType = MKMapType.satellite
        }else{
            mapTypeTitle.title = "Satellite"
            mapPage.mapType = MKMapType.standard
        }
    }


    @IBAction func zoomIn(_ sender: UIBarButtonItem) {
        let center = mapPage.centerCoordinate
        regionRadius = regionRadius * 0.5
        let viewRegion = MKCoordinateRegionMakeWithDistance(center, regionRadius, regionRadius)
        mapPage.setRegion(viewRegion, animated: false)
    }
    
    @IBAction func zoomOut(_ sender: UIBarButtonItem) {
        let center = mapPage.centerCoordinate
        regionRadius = regionRadius * 1.5
        let viewRegion = MKCoordinateRegionMakeWithDistance(center, regionRadius, regionRadius)
        mapPage.setRegion(viewRegion, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 43.100347, longitude: -71.276269)
        centerMapOnLocation(location: initialLocation)
        requestLocationAccess()
        addAnnotations()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapPage.setRegion(coordinateRegion, animated: true)
    }
    
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    func addAnnotations() {
        mapPage?.delegate = self
        mapPage?.addAnnotations(places as! [MKAnnotation])
    }
}
extension mapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
            
        else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "place_icon_SNHSS")
            annotationView.canShowCallout = true
            return annotationView
        }
    }
    
}
