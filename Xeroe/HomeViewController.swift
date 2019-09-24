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
    
    
    @IBOutlet weak var xeroeIDTextField: TextFieldWithCorner! {
        didSet {
            xeroeIDTextField.fontSize = xeroeIDTextFieldFontSize
            xeroeIDTextField.placeholder = insertXeroeID
            xeroeIDTextField.leftInsets = xeroeIDTextField.frame.width * 0.10
            xeroeIDTextField.addTarget(self, action: #selector(xeroeIDTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        }
    }
    
    @IBOutlet weak var openLeftMenuButton: UIButton! {
        didSet {
            openLeftMenuButton.addTarget(self, action: #selector(openLeftMenuButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var inputButton: ButtonWithCornerRadius! {
        didSet {
            inputButton.addTarget(self, action: #selector(inputButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var pointLabel: UILabel! {
        didSet {
            pointLabel.textColor = borderTextFieldColor
        }
    }
    
    var dictionaryClientData: [String : Any]?
    
    let locationManager = CLLocationManager()
    let viewModel = HomeViewModel()
    var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        viewModel.goToNextScreen = { [weak self] dict in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToNextScreen(dictionary: dict)
            }
        }
        
        viewModel.showAlertInputButtonTap = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.showAlertInputButtonTap(message: "message")
            }
        }
        
        viewModel.goToLoginScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToLoginScreen()
            }
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        // To initialize locationManager (). Now it can give you the user location.
        
        
    }
    
    @objc func inputButtonTap() {
        activityIndicator = self.view.showActivityIndicator()
        viewModel.findUser(xeroeIDTextField: xeroeIDTextField)
    }
    
    @objc func openLeftMenuButtonTap() {
        HamburgerMenu().triggerSideMenu()
    }
    
    @objc func xeroeIDTextFieldDidChange(_ textField: UITextField) {
        
        //changes color point before the text you
        guard var xeroeIDText = textField.text, xeroeIDText != "" else {
            pointLabel.textColor = borderTextFieldColor
            return
        }
        pointLabel.textColor = blackTextColor
        
        xeroeIDText = xeroeIDText.filter { $0.isNumber || $0.isLetter}
        
        //adds a sharp before the entered IDXeroe
        if xeroeIDText.isEmpty || xeroeIDText == "#" {
            textField.text = ""
            pointLabel.textColor = borderTextFieldColor
        } else {
            textField.text = "#" + xeroeIDText
        }
    }
    
    func showAlertInputButtonTap(message: String){
        let alert = UIAlertController(title: invalidXeroeID, message: (message), preferredStyle: UIAlertController.Style.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: false, completion: nil)
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
    
    func dropPinZoomIn(placemark: MKPlacemark){   // This function will "poste" the dialogue bubble of the pin.
        
        // clear existing pins to work with only one dialogue bubble.
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()    // The dialogue bubble object.
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name// Here you should test to understand where the location appear in the dialogue bubble.
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = String((city))+String((state));
        } // To "post" the user location in the bubble.
        
        mapView.addAnnotation(annotation)     // To initialize the bubble.
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)   // To update the map with a center and a size.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Func has been summoned")
        
        let locationsArray = locations as NSArray
        let locationObject = locationsArray.lastObject as? CLLocation
        if (locationObject != nil) {
            _ = locationObject?.coordinate.latitude
            let newCoordinateLong = locationObject?.coordinate.longitude
            
            print("Begin the func!")
            print("\(String(describing: newCoordinateLong))")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        return
    }
    
}

