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
//import GooglePlaces
//import GoogleMaps

fileprivate let orderVCIdentifier = "OrderDetailsViewController"
fileprivate let loginVCIdentifier = "LoginViewController"
fileprivate let cellIdentifier = "ResultAddressTableViewCell"
fileprivate let defaultCoordinate = CLLocationCoordinate2D(latitude: 39.799372, longitude: -89.644458)


fileprivate let limitDistance: Double = 16090

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
    @IBOutlet weak var startPointTextField: UITextField! {
        didSet {
            startPointTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidBegin)
            startPointTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            startPointTextField.autoresizingMask = .flexibleWidth
        }
    }
    
    @IBOutlet weak var startPointTableView: UITableView!
    @IBOutlet weak var endPointTextField: UITextField!{
        didSet {
            endPointTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            endPointTextField.autoresizingMask = .flexibleWidth
        }
    }
    @IBOutlet weak var endPointTableView: UITableView!
    
    @IBOutlet weak var startTableHeight: NSLayoutConstraint!
    @IBOutlet weak var endTableHeight: NSLayoutConstraint!
    @IBOutlet weak var goToOrderButton: UIButton! {
        didSet {
            goToOrderButton.addTarget(self, action: #selector(goToOrderButtonTap), for: .touchUpInside)
            self.goToOrderButton.isHidden = false
        }
    }
    
    let locationManager = CLLocationManager()
    let viewModel = HomeViewModel()
    var activityIndicator: UIActivityIndicatorView?
    var location: CLLocation?
    //    var fetcher: GMSAutocompleteFetcher?
    let completer = MKLocalSearchCompleter()
    
    var distanceIsLong = false
    
    var startPointSearchResult: [MKLocalSearchCompletion]?
    var endPointSearchResult: [MKLocalSearchCompletion]?
    var startPointDelegateDataSource = SearchResultTableDataSourceDelegate()
    var endPointDelegateDataSource = SearchResultTableDataSourceDelegate()
    var startPointIsCorrect = false
    var endPointIsCorrect = false
    
    var startPoinCoordinate: MKMapItem?
    var endPoinCoordinate: MKMapItem?
    var route: MKRoute?
    
    
    @objc func inputButtonTap() {
        activityIndicator = self.view.showActivityIndicator()
    }
    
    @objc func openLeftMenuButtonTap() {
        HamburgerMenu.triggerSideMenu()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 2 {
            completer.queryFragment = textField.text ?? ""
        }
        goToOrderButton.isHidden = true
    }
    
    @objc func goToOrderButtonTap() {
        if distanceIsLong {
            let alert = UIAlertController(title: alertTitleLimitDistance, message: (alertMessageLimitDistance), preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: ok, style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: false, completion: nil)
            
        } else {
            goToNextScreen()
        }
    }
    
    override func viewDidLoad() {
        goToOrderButton.isHidden = true
        viewModel.tokenValidation()
        checkUsersLocationServicesAuthorization()
        activateMapAndLocationManager()
        funcViewModel()
        searchAndFilterAddresse()
        registerTablesWithResultSearching()
    }
    
    func goToNextScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: orderVCIdentifier) as! OrderDetailsViewController
        initialViewController.addWaypointsToOrder(startAddress: startPointTextField.text, finishAddress: endPointTextField.text, startPoinCoordinate: self.startPoinCoordinate?.placemark.coordinate, endPoinCoordinate: self.endPoinCoordinate?.placemark.coordinate, route: route)
        
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    
    func goToLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: loginVCIdentifier) as! LoginViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    fileprivate func registerTablesWithResultSearching() {
        startPointDelegateDataSource.setParameters(textField: startPointTextField, resultArray: startPointSearchResult, tableView: startPointTableView, tableHeight: startTableHeight, delegate: self, isStart: true)
        endPointDelegateDataSource.setParameters(textField: endPointTextField, resultArray: endPointSearchResult, tableView: endPointTableView, tableHeight: endTableHeight, delegate: self, isStart: false)
        
        startPointTableView.delegate = startPointDelegateDataSource
        startPointTableView.dataSource = startPointDelegateDataSource
        endPointTableView.delegate = endPointDelegateDataSource
        endPointTableView.dataSource = endPointDelegateDataSource
        endPointTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        startPointTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        startPointDelegateDataSource.mapView = mapView
        endPointDelegateDataSource.mapView = mapView
    }
    
    //MARK: viewModel functions
    fileprivate func funcViewModel() {
        viewModel.goToNextScreen = { [weak self] dict in
            self?.activityIndicator?.stopAnimating()
            DispatchQueue.main.async {
                self?.goToNextScreen()
            }
        }
        
        viewModel.goToLoginScreen = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator?.stopAnimating()
                self?.goToLoginScreen()
            }
        }
    }
    
    func searchAndFilterAddresse() {
        
        completer.delegate = self;
        
        // Limit search results to the map view's current region.
        completer.region = mapView.region

        //        // Set up the autocomplete filter.
        //        let filter = GMSAutocompleteFilter()
        //        filter.type = .address
        //        filter.country = "UK"
        //        // Create a new session token.
        //        let token: GMSAutocompleteSessionToken = GMSAutocompleteSessionToken.init()
        //
        //        // Create the fetcher.
        //        fetcher = GMSAutocompleteFetcher(bounds: .none, filter: filter)
        //        fetcher?.delegate = self
        //        fetcher?.provide(token)
        
    }
    
    func checkUsersLocationServicesAuthorization(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .restricted, .denied:
                debugPrint("No access")
            case .notDetermined:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "AccessLocationViewController") as! AccessLocationViewController
                self.navigationController?.pushViewController(initialViewController, animated: false)
                debugPrint("notDetermined")
            case .authorizedAlways, .authorizedWhenInUse:
                debugPrint("Access")
            @unknown default:
                break
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    //MARK: delegate CLLocationManagerDelegate functions
    fileprivate func activateMapAndLocationManager() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.region = MKCoordinateRegion(mapView.visibleMapRect)
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
}

//extension HomeViewController: GMSAutocompleteFetcherDelegate {
//    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
//
//        let resultsStr = NSMutableString()
//        var arrayResult = [""]
//        if predictions.count > 0 {
//            for item in 0...predictions.count - 1 {
//                if item == 0 {
//                    arrayResult = [predictions[item].attributedFullText.string]
//                } else {
//                    arrayResult.append(predictions[item].attributedFullText.string)
//                }
//            }
//        }
//        print(resultsStr)
//
//        if startPointTextField.isEditing {
//            startPointDelegateDataSource.setResult(resultArray: arrayResult)
//            startPointTableView.reloadData()
//        } else {
//            endPointDelegateDataSource.setResult(resultArray: arrayResult)
//            endPointTableView.reloadData()
//        }
//        self.loadViewIfNeeded()
//        self.viewDidLayoutSubviews()
//        self.updateViewConstraints()
//    }
//
//    func didFailAutocompleteWithError(_ error: Error) {
//        debugPrint(error.localizedDescription)
//    }
//}


extension HomeViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let result = completer.results
        
        dump(result)
        
        if startPointTextField.isEditing {
            startPointDelegateDataSource.setResult(resultArray: result)
            startPointTableView.reloadData()
        } else {
            endPointDelegateDataSource.setResult(resultArray: result)
            endPointTableView.reloadData()
        }
        self.loadViewIfNeeded()
        self.viewDidLayoutSubviews()
        self.updateViewConstraints()
        
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        debugPrint("Oooops, problem with MKLocalSearchCompleter")
    }
}

extension HomeViewController: SearchResultTableDelegate {
    
    func chooseAddress(isStart: Bool, mapItem: MKMapItem) {
        if isStart {
            self.startPointIsCorrect = true
            self.startPoinCoordinate = mapItem
        } else {
            self.endPointIsCorrect = true
            self.endPoinCoordinate = mapItem
        }
        
        if startPointIsCorrect, endPointIsCorrect {
            goToOrderButton.isHidden = false
            
            mapView.reloadInputViews()
            let directionRequest = MKDirections.Request()
            directionRequest.source = startPoinCoordinate
            directionRequest.destination = endPoinCoordinate
            directionRequest.transportType = .automobile
            
            //remove previos route
            self.mapView.removeOverlays(self.mapView.overlays(in: MKOverlayLevel.aboveRoads))
            
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
                self.route = response.routes[0]
                
                if let route = self.route, let startLatitude = self.startPoinCoordinate?.placemark.coordinate.latitude, let startLongitude = self.startPoinCoordinate?.placemark.coordinate.longitude, let endLatitude = self.endPoinCoordinate?.placemark.coordinate.latitude, let endLongitude = self.endPoinCoordinate?.placemark.coordinate.longitude {
                    let latitudeCenterLocation = (startLatitude + endLatitude) / 2
                    let longitudeCenterLocation = (startLongitude + endLongitude) / 2
                    let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
                    let region = MKCoordinateRegion(center: location , latitudinalMeters: route.distance, longitudinalMeters: route.distance)
                    self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
                    self.distanceIsLong = route.distance  > limitDistance
                    self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                    
                }
                self.mapView.setNeedsDisplay()
                
            }
        } else {
            self.goToOrderButton.isHidden = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.99, green: 0.39, blue: 0.67, alpha: 1)
        renderer.lineWidth = 4.0
        return renderer
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
        
        guard let startCoordinate = self.startPoinCoordinate?.placemark.coordinate else {
            return annotationView
        }
        let pinImage = (annotation.coordinate.latitude == startCoordinate.latitude && annotation.coordinate.longitude == startCoordinate.longitude) ? UIImage(named: "collection") : UIImage(named: "delivery")
        
        
        annotationView?.image = pinImage
        return annotationView
    }
}

