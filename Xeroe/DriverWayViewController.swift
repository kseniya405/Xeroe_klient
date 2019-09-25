//
//  DriverWayViewController.swift
//  Xeroe
//
//  Created by Денис Марков on 9/17/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

fileprivate let defaultCoordinate = CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458)

class DriverWayViewController: MapWithDriverViewController {
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusValue: UILabel!
    @IBOutlet weak var infoAboutTimer: UILabel!
    @IBOutlet weak var timerImage: UIImageView! {
        didSet {
            timerImage.image = UIImage(named: "timer")
        }
    }
    @IBOutlet weak var timerValue: UILabel!
    @IBOutlet weak var infoWithTimer: UIStackView!
    @IBOutlet weak var waitingRecipientConfirm: UILabel! {
        didSet {
            waitingRecipientConfirm.text = "Waiting for recipient to confirm the delivery"
        }
    }
    @IBOutlet weak var showQRButton: UIButton! {
        didSet {
            showQRButton.addTarget(self, action: #selector(showQRButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var driverRateView: UIView!
    @IBOutlet weak var confirmRateButton: ButtonWithCornerRadius!{
        didSet {
            confirmRateButton.addTarget(self, action: #selector(confirmRateButtonTap), for: .touchUpInside)
        }
    }
    
    var finalRoute = MKRoute()
    
    override func viewDidLoad() {
        mapView.delegate = self
        self.showDriverData()
        self.getRoute { (route) in
            self.finalRoute = route
            self.statusValue.text = "Delivery status: collected"
        }
        runDriverWaitingTimer(valueTimer: 3) { (isOk) in
            self.statusValue.text = "Delivery status: at collection point"
            self.timerValue.text = "15:00"
            self.infoAboutTimer.text = "Goods should be delivered in"

            self.getRoutPoints(route: self.finalRoute) { (isOk) in
                self.statusValue.text = "Delivery status: on the way"
            }

            self.runDriverWaitingTimer(valueTimer: 15) { (isOk) in
                self.statusValue.text = "Delivery status: arrived at destination"
                self.infoAboutTimer.text = "Driver: waiting"
                self.timerValue.text = "0:00"
                self.runDriverWaitingStopwatch(callback: { (isOk) in
                    self.statusValue.text = "Delivery status: delivered"
                    self.infoWithTimer.isHidden = true

                    if userIsSender ?? false {
                        self.waitingRecipientConfirm.isHidden = false
                    } else {
                        self.showQRButton.isHidden = false
                    }
                })
            }
        }
    }
    
    @objc func confirmRateButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        initialViewController.identifier = "HomeViewController"
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func showQRButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        initialViewController.delegate = self 
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
     func getRoute(callback: @escaping (MKRoute) -> Void) {
        convertAddressToCoordinate(from: userAddress) { sourceLocationBack in
            self.convertAddressToCoordinate(from: clientAddress) { destinationLocationBack in
                
                self.locationStart = sourceLocationBack ?? defaultCoordinate
                let sourceMapItem = self.setMapItem(location: sourceLocationBack ?? defaultCoordinate)
                
                let destinationMapItem = self.setMapItem(location: destinationLocationBack ?? defaultCoordinate)
                self.locationFinish = destinationLocationBack ?? defaultCoordinate
                
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceMapItem
                directionRequest.destination = destinationMapItem
                directionRequest.transportType = .automobile
                
                // Calculate the direction
                let directions = MKDirections(request: directionRequest)
                
                directions.calculate {
                    (response, error) -> Void in
                    
                    guard let response = response else {
                        if let error = error {
                            print("Error: \(error)")
                        }
                        callback(MKRoute())
                        return
                    }
                    let finalRoute = response.routes[0]

                    let latitudeCenterLocation = (sourceLocationBack!.latitude  + destinationLocationBack!.latitude) / 2 * 0.9995
                    let longitudeCenterLocation = (sourceLocationBack!.longitude  + destinationLocationBack!.longitude) / 2
                    let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
                    let region = MKCoordinateRegion(center: location , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
                    
                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    self.mapView.addOverlay(finalRoute.polyline, level: MKOverlayLevel.aboveRoads)
                    
                    callback(finalRoute)
                }
            }
        }
    }
    
    func showDriverData() {
        self.driverDataView.slideIn(from: .up)
        self.statusView.slideIn(from: .up)
    }
    
    func runDriverWaitingTimer(valueTimer: Int, callback: @escaping (Bool) -> Void) {
        var minLeft: Int = valueTimer
        var secLeft: Int = 0
        var timerCount: Int = valueTimer * 60 - 1
        //        let confirmationTime = Int.random(in: 0 ..< valueTimer * 60 - 10)
        let confirmationTime = valueTimer * 60 - 10
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            minLeft = timerCount / 60
            secLeft = timerCount % 60
            self.timerValue.text = secLeft < 10 ? "\(minLeft):0\(secLeft)" : "\(minLeft):\(secLeft)"
            timerCount -= 1
            
            if timerCount == confirmationTime {
                timer.invalidate()
                callback(true)
            }
        }
    }
    
    func runDriverWaitingStopwatch(callback: @escaping (Bool) -> Void) {
        
        var minLeft: Int = 0
        var secLeft: Int = 1
        var timerCount: Int = 0
        //        let confirmationTime = Int.random(in: 0 ..< valueTimer * 60 - 10)
        let confirmationTime = 8
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            minLeft = timerCount / 60
            secLeft = timerCount % 60
            self.timerValue.text = secLeft < 10 ? "\(minLeft):0\(secLeft)" : "\(minLeft):\(secLeft)"
            timerCount += 1
            
            if timerCount == confirmationTime {
                timer.invalidate()
                callback(true)
            }
        }
    }

}

extension DriverWayViewController: QRCodeViewControllerDelegate {
    func changView() {
        self.driverDataView.isHidden = true
        self.statusView.isHidden = true
        self.driverRateView.isHidden = false
        self.driverRateView.slideIn(from: .up)
    }
}
