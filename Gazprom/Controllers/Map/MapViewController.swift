//
//  MapViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SVProgressHUD

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    let annotationsPoints = [["title": "Ул. Панфилова 147/2", "latitude":42.866005, "longitude":74.600265]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatAnnotations(locations: annotationsPoints)
        checkLocationServices()
        
    }
    func setupLocationManager() {
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthtorization()
        }else{
            //show alert
        }
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
        
    }
    func checkLocationAuthtorization()  {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
           starttrackingUserLocation()
        case .denied:
            //show alert turn on permission
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //show alert 
            break
        case .authorizedAlways:
            break
        }
    }
    
    func starttrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for MapView: MKMapView) -> CLLocation {
        let latitude = MapView.centerCoordinate.latitude
        let longitude = MapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
        
    }

    var placeMark: CLPlacemark?
    @IBAction func goButtonTapped(_ sender: Any) {
        guard let placeMark = placeMark  else { return }
        
        let directionRequest = MKDirections.Request()
        let destinationPlacemark = MKPlacemark(placemark: placeMark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            
            guard let response = response else {
                if let error = error{
                    print("error", error)
                }
                return
            }
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
        }
        
        
        //getDirections()
    }
    
    func creatAnnotations(locations: [[String: Any]]) {
        for location in locations{
            let annotations = MKPointAnnotation()
            annotations.title = location["title"] as? String
            annotations.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            mapView.addAnnotation(annotations)
        }
    }
}



extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthtorization()
    }
}
extension MapViewController: MKMapViewDelegate{
  
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let coordinate = CLLocationCoordinate2D(latitude: 0000, longitude: 0000)
        let location = view.annotation
        self.placeMark = MKPlacemark(coordinate: location?.coordinate ?? coordinate)
    }
}


