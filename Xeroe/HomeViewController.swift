//
//  ViewController.swift
//  Card #6
//
//  Created by Денис Марков on 7/28/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import GoogleMaps


class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var xeroeIDTextField: TextFieldWithCorner!
    
    @IBAction func hamburgerBtnAction(_ sender: UIButton) {
        //Make Object of HamburgerMenu Class and call this function.
        HamburgerMenu().triggerSideMenu()
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var inputButton: ButtonWithCornerRadius! {
        didSet {
            
            inputButton.addTarget(self, action: #selector(inputButtonTap), for: .touchUpInside)

        }
    }
    
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
    }
    
    @objc func inputButtonTap() {
        self.showActivityIndicatory(uiView: self.view)
        guard let textID = xeroeIDTextField.text, !textID.isEmpty else {
            showAlertInputButtonTap()
            return
        }
        RestApi().findID(xeroeID: textID) { (isOk) in
            DispatchQueue.main.async {
                guard isOk else {
                    self.showAlertInputButtonTap()
                    return
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "RecipientDetailViewController") as! RecipientDetailViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
                
            }
        }

    }
    

    @objc func showAlertInputButtonTap(){
        let alert = UIAlertController(title: "Invalid xeroeID", message: "This is my message.", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    let locationManager = CLLocationManager()
    //var mapView: GMSMapView?
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        
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

