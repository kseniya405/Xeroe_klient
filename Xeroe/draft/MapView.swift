////
////  MapView.swift
////  Xeroe
////
////  Created by Денис Марков on 8/2/19.
////  Copyright © 2019 Денис Марков. All rights reserved.
////
//
//import UIKit
//
//class MapView: UIView {
//    
//    let locationManager = CLLocationManager()
//    var mapView: GMSMapView?
//    
//    override func awakeFromNib() {
//        
//        // Ask for Authorisation from the User.
//        self.locationManager.requestAlwaysAuthorization()
//        
//        // For use in foreground
//        self.locationManager.requestWhenInUseAuthorization()
//        
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self as? CLLocationManagerDelegate
//            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//            locationManager.startUpdatingLocation()
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        debugPrint("locations = \(locValue.latitude) \(locValue.longitude)")
//        
//        // Create a GMSCameraPosition that tells the map to display the
//        // coordinate -33.86,151.20 at zoom level 6.
//        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 6.0)
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        
//        if let map = mapView {
//            self.mapView = map
//        }
//        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
//        marker.map = mapView
//    }
//
//}
