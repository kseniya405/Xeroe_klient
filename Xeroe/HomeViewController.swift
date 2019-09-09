//
//  HomeViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 7/28/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import GoogleMaps

fileprivate let recipientVCIdentifier = "FoundUserDetailViewController"
fileprivate let xeroeIDTextFieldFontSize = 18

class HomeViewController: UIViewController, CLLocationManagerDelegate {
    
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
    @IBOutlet weak var mapView: GMSMapView!
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
        viewModel.goToNextScreen = { [weak self] dict in
            DispatchQueue.main.async {
                self?.goToNextScreen(dictionary: dict)
            }
        }
        
        viewModel.showAlertInputButtonTap = { [weak self] in
            DispatchQueue.main.async {
                self?.showAlertInputButtonTap()
            }
        }

    }
    
    @objc func inputButtonTap() {
        let activityIndicator = self.view.showActivityIndicator()
        viewModel.findUser(xeroeIDTextField: xeroeIDTextField, activityIndicator: activityIndicator)
    }
    
    @objc func openLeftMenuButtonTap() {
        HamburgerMenu().triggerSideMenu()
    }
    
    @objc func xeroeIDTextFieldDidChange(_ textField: UITextField) {
        
        //changes color point before the text you
        guard let xeroeIDText = textField.text, xeroeIDText != "" else {
            pointLabel.textColor = borderTextFieldColor
            return
        }
        pointLabel.textColor = blackTextColor
        
        //adds a sharp before the entered IDXeroe
        let sharp = "#"
        if xeroeIDText == sharp {
            textField.text = ""
            pointLabel.textColor = borderTextFieldColor
        } else if (!textField.text!.hasPrefix(sharp)) {
            textField.text = sharp + textField.text!
        }
    }
    
    func showAlertInputButtonTap(){
        let alert = UIAlertController(title: invalidXeroeID, message: userNotFound, preferredStyle: UIAlertController.Style.alert)
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

