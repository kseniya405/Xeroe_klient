//
//  AccessLocationViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 10/7/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import CoreLocation

fileprivate let homeVCIdentifier = "HomeViewController"

class AccessLocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var allowAccessButton: ButtonWithCornerRadius! {
        didSet {
            allowAccessButton.addTarget(self, action: #selector(allowAccessButtonTap), for: .touchUpInside)
        }
    }
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func allowAccessButtonTap() {
        locationManager.delegate = self
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.dismiss()
    }
}
