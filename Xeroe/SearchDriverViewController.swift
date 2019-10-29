//
//  SearchDriverViewController.swift
//  
//
//  Created by Денис Марков on 9/11/19.
//

import UIKit
import MapKit
import CoreLocation

fileprivate let defaultCoordinate = CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458)

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
            timeToArriveTitle.setLabelStyle(textLabel: timeToArrive, fontLabel: UIFont(name: robotoRegular, size: sizeFontError), colorLabel: .white)
        }
    }
    
    @IBOutlet weak var timeToArriveValue: UILabel! {
        didSet {
            timeToArriveTitle.setLabelStyle(fontLabel: UIFont(name: robotoBold, size: 16), colorLabel: .white)
        }
    }
    
    @objc func cancelButtonTap() {
        visibleView()
        self.timeToArriveView.alpha = 0
        showDriverData()
    }
    
    @objc func confirmButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        initialViewController.identifier = "DriverWayViewController"
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    override func viewDidLoad() {
        setCoordinate()
        mapView.delegate = self
        self.showDriverData()
        getDirections()
    }
    
    func setCoordinate() {
        self.locationStart = Address.shared.collection ?? defaultCoordinate
        self.locationFinish = Address.shared.delivery ?? defaultCoordinate
    }
    
    
    override func getDirections() {
        
        let _ = self.setMapItem(location: CLLocationCoordinate2D(latitude: self.locationStart.latitude * 0.9999, longitude: self.locationStart.longitude * 1.2))
        
        let sourceMapItem = self.setMapItem(location: locationStart)
        
        let destinationMapItem = self.setMapItem(location: locationFinish)
        
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
                    debugPrint("Error: \(error)")
                }
                return
            }
            debugPrint("responce", response)
            let route = response.routes[0]
            
            let latitudeCenterLocation = (self.locationStart.latitude  + self.locationFinish.latitude) / 2 * 0.9995
            let longitudeCenterLocation = (self.locationStart.longitude + self.locationFinish.longitude) / 2
            let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
            let region = MKCoordinateRegion(center: location , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
            
            self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
        
    }
    
    func showDriverData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.visibleView()
            self.driverDataView.slideOut(from: .down)
            self.driverDataView.slideIn(from: .up)
            
            
            UIView.animate(withDuration: 1.5, animations: {
                self.timeToArriveView.alpha = 1.0
            })
        }
        
    }
    
    func visibleView() {
        self.searhDriverView.isHidden = !self.searhDriverView.isHidden
        self.leftMenuButton.isHidden = !self.leftMenuButton.isHidden
        self.driverDataView.isHidden = !self.driverDataView.isHidden
    }
    
}

