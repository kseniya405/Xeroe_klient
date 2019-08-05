//
//  ViewController.swift
//  Card #6
//
//  Created by Денис Марков on 7/28/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var loadMenu: UIButton!{
        didSet {
            loadMenu.layer.cornerRadius = 2
            loadMenu.layer.masksToBounds = true
            loadMenu.addTarget(self, action: #selector(login), for: .touchUpInside)
        }
    }
    
    
    @IBAction func hamburgerBtnAction(_ sender: UIButton) {
        //Make Object of HamburgerMenu Class and call this function.
        HamburgerMenu().triggerSideMenu()
    }

    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var button: UIButton!
    // You don't need to modify the default init(nibName:bundle:) method.
    
    @objc func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: true)
    }
    
    let locationManager = CLLocationManager()
    //var mapView: GMSMapView?
    
    override func viewDidLoad() {
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        //let lm = LeftMenuViewController()
        //self.present(lm, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude, zoom: 6.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        marker.map = mapView
        
    }

}

