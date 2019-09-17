//
//  SearchDriverViewController.swift
//  
//
//  Created by Денис Марков on 9/11/19.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation

fileprivate let defaultCoordinations = CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458)

class SearchDriverViewController: MapWithDriverViewController {
    
    @IBOutlet weak var confirmButton: ButtonWithCornerRadius! {
        didSet {
            confirmButton.addTarget(self, action: #selector(confirmButtonTap), for: .touchUpInside)
        }
    }
    @IBOutlet weak var cancelButton: ButtonWithCornerRadius! {
        didSet {
            cancelButton.layer.borderColor = basicBlueColor.cgColor
            cancelButton.layer.borderWidth = 1
            cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var timeToArriveView: UIView! {
        didSet {
            timeToArriveView.layer.masksToBounds = true
            timeToArriveView.layer.cornerRadius = 4
    
        }
        
    }
    
    @IBOutlet weak var timeToArriveTitle: UILabel! {
        didSet {
            timeToArriveTitle.setLabelStyle(textLabel: timeToArrive, fontLabel: UIFont(name: robotoRegular, size: 12), colorLabel: .white)
        }
    }
    
    @IBOutlet weak var timeToArriveValue: UILabel! {
        didSet {
            timeToArriveTitle.setLabelStyle(fontLabel: UIFont(name: robotoBold, size: 16), colorLabel: .white)
        }
    }
    
    @objc func cancelButtonTap() {
        visibleView()
        showDriverData()
    }
    
    @objc func confirmButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tabbar = "DriverWayViewController"
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    override func viewDidLoad() {
        mapView.delegate = self
        self.showDriverData()
        getDirections()
    }
    
    
    override func getDirections() {
        convertAddressToCoordinate(from: userAddress) { sourceLocationBack in
            self.convertAddressToCoordinate(from: clientAddress) { destinationLocationBack in

                self.locationStart = sourceLocationBack ?? defaultCoordinations
                let sourceMapItem = self.setMapItem(location: sourceLocationBack ?? defaultCoordinations)
                
                let _ = self.setMapItem(location: CLLocationCoordinate2D(latitude: self.locationStart.latitude * 0.9999, longitude: self.locationStart.longitude * 1.2))
                
                let destinationMapItem = self.setMapItem(location: destinationLocationBack ?? defaultCoordinations)
            
                self.locationFinish = destinationLocationBack ?? defaultCoordinations
                
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
                        return
                    }
                    print("responce", response)
                    let route = response.routes[0]
                    
                    let latitudeCenterLocation = (sourceLocationBack!.latitude  + destinationLocationBack!.latitude) / 2 * 0.9995
                    let longitudeCenterLocation = (sourceLocationBack!.longitude  + destinationLocationBack!.longitude) / 2
                    let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
                    let region = MKCoordinateRegion(center: location , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)

                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                }
            }
        }
    }
    
    func showDriverData() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.visibleView()
            self.driverDataView.slideOut(from: .down)
            self.driverDataView.slideIn(from: .up)
            self.timeToArriveView.slideOut(from: .down)
            self.timeToArriveView.slideIn(from: .up)
        }
    }

    func visibleView() {
        self.searhDriverView.isHidden = !self.searhDriverView.isHidden
        self.leftMenuButton.isHidden = !self.leftMenuButton.isHidden
        self.driverDataView.isHidden = !self.driverDataView.isHidden
        self.timeToArriveView.isHidden = !self.timeToArriveView.isHidden
    }
    
}

