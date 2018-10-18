//
//  GoogleMapViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/15/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import GooglePlacePicker
import Alamofire

class GoogleMapViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var fromLocation = CLLocationCoordinate2D()
    var toLocation = CLLocationCoordinate2D()
    
    var markers = [MarkerModel]()
    let client = ApiClient()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getOffices()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    

        mapView = GMSMapView (frame: view.frame)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        let button = UIButton(frame: view.frame)
        let btnImage = UIImage(named: "mapOneWay")
        button.setImage(btnImage, for: .normal)
        button.frame = CGRect(x:260, y: 65, width: 48, height: 41)
        button.addTarget(self, action: #selector(GoogleMapViewController.addDirectionOnMap(sender:)), for: .touchUpInside)

        let buttonShare = UIButton(frame: view.frame)
        let btnImageShare = UIImage(named: "Map")
        buttonShare.setImage(btnImageShare, for: .normal)
        buttonShare.frame = CGRect(x:260, y: 400, width: 48, height: 41)
        buttonShare.addTarget(self, action: #selector(GoogleMapViewController.ShareMap(sender:)), for: .touchUpInside)
        
        view.addSubview(self.mapView)
        view.addSubview(buttonShare)
        view.addSubview(button)
        mapView.delegate = self
        
    }
    
    @objc func ShareMap(sender: UIButton)  {
        print("TapShare")
        
        let alert = UIAlertController(title: "Открыть", message: "", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "App Maps", style: .default) { (action) in
            print("openAppMap")
            UIApplication.shared.openURL(NSURL(string: "http://maps.apple.com/maps?saddr=\(self.fromLocation.latitude),\(self.fromLocation.longitude)&daddr=\(self.toLocation.latitude),\(self.toLocation.longitude)")! as URL)
           
        }
        let action2 = UIAlertAction(title: "Google Maps", style: .default) { (action) in
            
            UIApplication.shared.openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(self.toLocation.latitude),\(self.toLocation.longitude)&directionsmode=driving")! as URL)
        }
        let action3 = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        present(alert, animated: true, completion: nil)
    }
    

    
    @objc func addDirectionOnMap(sender: UIButton)  {
        print("Tap")
        print(fromLocation)
        print(toLocation)
        getPolylineRoute(from: fromLocation, to: toLocation)
    }
    
    func addMarkerPoints(markers: [MarkerModel]) {
        
        for marker in markers{
            if let lat = marker.latitude, let long = marker.longitude{
                let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let markerName = GMSMarker(position: position)
                markerName.title = marker.title
                markerName.map = mapView
            }
        }
    }
    
    func getOffices() {
        client.getOffices(successHandler: { (value) in
            
            let array = value
            for office in array {
                self.markers.append(office)
                print(office.latitude)
                print(office.longitude)
                print(office.title)
            }
            self.addMarkerPoints(markers: self.markers)
        }) { (error) in
            print(error)
        }
    }
}


extension GoogleMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude, zoom: 11);
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        fromLocation = center
        
        print("Latitude :- \(userLocation!.coordinate.latitude)")
        print("Longitude :-\(userLocation!.coordinate.longitude)")
  
        locationManager.stopUpdatingLocation()
 
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=walking&key=AIzaSyCMR7LuXqGKlRLC_J5ehXb9_DcTeYWgLLU")!
        print(url)
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        
                        let preRoutes = json["routes"] as! NSArray
                        let routes = preRoutes[0] as! NSDictionary
                        let routeOverviewPolyline:NSDictionary = routes.value(forKey: "overview_polyline") as! NSDictionary
                        let polyString = routeOverviewPolyline.object(forKey: "points") as! String
                        
                        DispatchQueue.main.async(execute: {
                            let path = GMSPath(fromEncodedPath: polyString)
                            let polyline = GMSPolyline(path: path)
                            polyline.strokeWidth = 5.0
                            polyline.strokeColor = UIColor.green
                            polyline.map = self.mapView
                        })
                    }
                    
                } catch {
                    print("parsing error")
                }
            }
        })
        task.resume()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension GoogleMapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
       
        print("didTap marString(describing: ker \(marker).title)")
        toLocation = CLLocationCoordinate2D(latitude: marker.position.latitude, longitude: marker.position.longitude)
                print(toLocation)
        return false
    }
}
