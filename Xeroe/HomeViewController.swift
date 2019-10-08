//
//  HomeViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/28/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


fileprivate let recipientVCIdentifier = "FoundUserDetailViewController"
fileprivate let loginVCIdentifier = "LoginViewController"

fileprivate let xeroeIDTextFieldFontSize = 18

class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var openLeftMenuButton: UIButton! {
        didSet {
            openLeftMenuButton.addTarget(self, action: #selector(openLeftMenuButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var foundAddressView: UIView! {
        didSet {
            foundAddressView.backgroundColor = basicBlueColor
        }
    }
    
    let locationManager = CLLocationManager()
    let viewModel = HomeViewModel()
    var activityIndicator: UIActivityIndicatorView?
    var location: CLLocation?
    
    override func viewDidLoad() {
        viewModel.tokenValidation()
        checkUsersLocationServicesAuthorization()
        activateMapAndLocationManager()
        funcViewModel()
    }
    
    @objc func inputButtonTap() {
        activityIndicator = self.view.showActivityIndicator()
    }
    
    @objc func openLeftMenuButtonTap() {
        HamburgerMenu.triggerSideMenu()
    }
    
    
    func goToNextScreen(dictionary: [String : Any]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: recipientVCIdentifier) as! FoundUserDetailViewController
        initialViewController.clientDataDictionary = dictionary
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: loginVCIdentifier) as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    //MARK: viewModel functions
    fileprivate func funcViewModel() {
        viewModel.goToNextScreen = { [weak self] dict in
            self?.activityIndicator?.stopAnimating()
            DispatchQueue.main.async {
                self?.goToNextScreen(dictionary: dict)
            }
        }
        
        
        viewModel.goToLoginScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToLoginScreen()
            }
        }
    }
    
    func checkUsersLocationServicesAuthorization(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "AccessLocationViewController") as! AccessLocationViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
            case .authorizedAlways, .authorizedWhenInUse:
                debugPrint("Access")
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "AccessLocationViewController") as! AccessLocationViewController
            self.navigationController?.pushViewController(initialViewController, animated: false)
        }
    }
    

    //MARK: delegate CLLocationManagerDelegate functions
    
    fileprivate func activateMapAndLocationManager() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        debugPrint("Func has been summoned")
        guard let coordinate = location?.coordinate else { return  }
        let locationPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let locationAnnotation = MKPointAnnotation()
        if let location = locationPlacemark.location {
            locationAnnotation.coordinate = location.coordinate
        }
        self.mapView.showAnnotations([locationAnnotation], animated: true)

       let region = MKCoordinateRegion(center: coordinate , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
       
       self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
    }
       
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let coordinate = CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458)
         let locationPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
         let locationAnnotation = MKPointAnnotation()
         if let location = locationPlacemark.location {
             locationAnnotation.coordinate = location.coordinate
         }
         self.mapView.showAnnotations([locationAnnotation], animated: true)

        let region = MKCoordinateRegion(center: coordinate , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
        
        self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
    }
}

