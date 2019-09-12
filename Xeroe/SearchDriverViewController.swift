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

class SearchDriverViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var searhDriverView: UIView!
    @IBOutlet weak var searchDriverLabel: UILabel!
    @IBOutlet weak var driverDataView: UIView!
    @IBOutlet weak var cancelButton: ButtonWithCornerRadius! {
        didSet {
            cancelButton.layer.borderColor = basicBlueColor.cgColor
            cancelButton.layer.borderWidth = 1
            cancelButton.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var leftMenuButton: UIButton! {
        didSet {
            leftMenuButton.addTarget(self, action: #selector(leftMenuButtonTap), for: .touchUpInside)
        }
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        mapView.delegate = self
        getDirections()
    }

    @objc func leftMenuButtonTap() {
        HamburgerMenu().triggerSideMenu()
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1)
        renderer.lineWidth = 2.0
        return renderer
    }
    
    fileprivate func getDirections() {
        getLocation(from: userAddress) { sourceLocationBack in
            self.getLocation(from: clientAddress) { destinationLocationBack in

                let sourceMapItem = self.setMapItem(location: sourceLocationBack ?? defaultCoordinations)
                let destinationMapItem = self.setMapItem(location: destinationLocationBack ?? defaultCoordinations)
                
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
                    print(response)
                    let route = response.routes[0]
                    
                    let latitudeCenterLocation = (sourceLocationBack!.latitude  + destinationLocationBack!.latitude) / 2 * 0.9995
                    let longitudeCenterLocation = (sourceLocationBack!.longitude  + destinationLocationBack!.longitude) / 2
                    let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
                    let region = MKCoordinateRegion(center: location , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)


                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
                    self.startSearhDriver()
                }
            }
        }

    }
    
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
                let location = placemarks.first?.location?.coordinate else {
                    return
            }
            completion(location)
        }
    }
    
    func setMapItem(location: CLLocationCoordinate2D) -> MKMapItem {
        let locationPlacemark = MKPlacemark(coordinate: location, addressDictionary: nil)
        let locationMapItem = MKMapItem(placemark: locationPlacemark)
        let locationAnnotation = MKPointAnnotation()
        if let location = locationPlacemark.location {
            locationAnnotation.coordinate = location.coordinate
        }
        self.mapView.showAnnotations([locationAnnotation], animated: true)
        return locationMapItem
    }
    
    func startSearhDriver() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.visibleView()
            StackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)

            // These values depends on the positioning of your element
            let left = CGAffineTransform(translationX: -300, y: 0)
            let right = CGAffineTransform(translationX: 300, y: 0)
            let top = CGAffineTransform(translationX: 0, y: -300)
            
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                // Add the transformation in this block
                // self.container is your view that you want to animate
                self.driverDataView.transform = top
            }, completion: nil)
        }
    }

    @objc func cancelButtonTap() {
        visibleView()
        startSearhDriver()
    
    }
    
    func visibleView() {
        self.searhDriverView.isHidden = !self.searhDriverView.isHidden
        self.leftMenuButton.isHidden = !self.leftMenuButton.isHidden
        self.driverDataView.isHidden = !self.driverDataView.isHidden
    }
}


