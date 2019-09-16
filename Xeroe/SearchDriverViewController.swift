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
    
    var locationStart: CLLocationCoordinate2D = defaultCoordinations
    var locationFinish: CLLocationCoordinate2D = defaultCoordinations
    
    var prevLocation: CLLocationCoordinate2D = defaultCoordinations
    var curLocation: CLLocationCoordinate2D = defaultCoordinations
    var radians: CGFloat = 0
    
    override func viewDidLoad() {
        mapView.delegate = self
        self.showDriverData()
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
        convertAddressToCoordinate(from: userAddress) { sourceLocationBack in
            self.convertAddressToCoordinate(from: clientAddress) { destinationLocationBack in

                self.locationStart = sourceLocationBack ?? defaultCoordinations
                let sourceMapItem = self.setMapItem(location: sourceLocationBack ?? defaultCoordinations)
                
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
                    
//                    self.getRoutPoints(route)
                    
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
    
    func convertAddressToCoordinate(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
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
    
    func showDriverData() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.visibleView()
            self.driverDataView.slideOut(from: .down)
            self.driverDataView.slideIn(from: .up)
        }
    }

    @objc func cancelButtonTap() {
        visibleView()
        showDriverData()
    }
    
    func visibleView() {
        self.searhDriverView.isHidden = !self.searhDriverView.isHidden
        self.leftMenuButton.isHidden = !self.leftMenuButton.isHidden
        self.driverDataView.isHidden = !self.driverDataView.isHidden
    }
    
    
    func getRoutPoints(_ route: MKRoute) {
        let polyline = route.polyline
        let mapPoints = polyline.points()
        
        var prevAnnotation = MKPointAnnotation()

        var point = 0
        
        let interval = 15 * 60 / polyline.pointCount
        Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true) { timer in
                        
            self.radians = CGFloat(self.cornerTurningMarks(prevCoordinate: mapPoints[point].coordinate, curCoordinate: mapPoints[point+1].coordinate))

            let location = mapPoints[point].coordinate
            self.curLocation = location

            print("location ", location)
            let currentAnnotation = MKPointAnnotation()
            currentAnnotation.coordinate = location
            currentAnnotation.subtitle = "Driver"
            
            self.mapView.addAnnotation(currentAnnotation)
            self.mapView.removeAnnotations([prevAnnotation])
            self.mapView.addAnnotation(currentAnnotation)

            prevAnnotation = currentAnnotation
            point += 1
            self.prevLocation = location

            if point == polyline.pointCount - 1 {
                timer.invalidate()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if annotation.coordinate.latitude != locationStart.latitude, annotation.coordinate.longitude != locationStart.longitude,
            annotation.coordinate.latitude != locationFinish.latitude, annotation.coordinate.longitude != locationFinish.longitude {
            print(curLocation)
            let pinImage = UIImage(named: "annotation")
            
            annotationView?.image = pinImage?.rotate(radians: CGFloat(radians))
            print("set image", radians)
        } else {
            let pinImage = UIImage(named: "mark")
            annotationView?.image = pinImage
        }

        return annotationView
    }
    
    func cornerTurningMarks(prevCoordinate: CLLocationCoordinate2D, curCoordinate: CLLocationCoordinate2D) -> Double {
        
        let differrenceLatitudeIsPositive = (curCoordinate.latitude - prevCoordinate.latitude) >= 0

        let xOffcetVectorA = curCoordinate.latitude - prevCoordinate.latitude
        let yOffcetVectorA = curCoordinate.longitude - prevCoordinate.longitude
        let yOffcetVectorB = curCoordinate.longitude
        
        let step1 = yOffcetVectorA * yOffcetVectorB
        let step2 = sqrt(xOffcetVectorA * xOffcetVectorA + yOffcetVectorA * yOffcetVectorA) * sqrt(yOffcetVectorB * yOffcetVectorB)
        let cosAB = step1/step2
        let radiusAB  = acos(cosAB)
        
        
        return differrenceLatitudeIsPositive ? radiusAB : -radiusAB
    }
}

