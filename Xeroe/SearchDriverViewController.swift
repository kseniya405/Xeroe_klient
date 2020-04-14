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

class SearchDriverViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
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
    
    
    @IBOutlet weak var searhDriverView: UIView!
    @IBOutlet weak var searchDriverLabel: UILabel!
    
    @IBOutlet weak var driverDataView: UIView!
    
    @IBOutlet weak var driverNameTitle: UILabel! {
        didSet {
            driverNameTitle.setLabelStyle(textLabel: driverName, fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    @IBOutlet weak var driverNameValue: UILabel!
    @IBOutlet weak var xeroeIDLabel: UILabel! {
        didSet {
            xeroeIDLabel.setLabelStyle(fontLabel: UIFont(name: robotoMedium, size: sizeFontBasic), colorLabel: blackTextColor)
        }
    }
    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!  {
        didSet {
            rateLabel.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    @IBOutlet weak var estimateTitle: UILabel! {
        didSet {
            estimateTitle.setLabelStyle(textLabel: estimateTimeForTrip, fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    @IBOutlet weak var estimateValue: UILabel! {
        didSet {
            estimateValue.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 16), colorLabel: blackTextColor)
        }
    }
    @IBOutlet weak var carTitle: UILabel! {
        didSet {
            carTitle.setLabelStyle(textLabel: car, fontLabel: UIFont(name: robotoRegular, size: sizeFontBasic), colorLabel: grayTextColor)
        }
    }
    @IBOutlet weak var carValue: UILabel! {
        didSet {
            carValue.setLabelStyle(fontLabel: UIFont(name: robotoRegular, size: 16), colorLabel: blackTextColor)
        }
    }
    @IBOutlet weak var reportButton: UIButton! {
        didSet {
            reportButton.addTarget(self, action: #selector(reportButtonTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var leftMenuButton: UIButton! {
        didSet {
            leftMenuButton.addTarget(self, action: #selector(leftMenuButtonTap), for: .touchUpInside)
        }
    }
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
    
    @IBOutlet weak var driverPhotoImageView: UIImageView! {
        didSet {
            driverPhotoImageView.layer.cornerRadius = driverPhotoImageView.frame.height / 2
            driverPhotoImageView.layer.masksToBounds = true
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
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var bottomViewWithTimer: UIView!
    
    @IBOutlet weak var heightMapView: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    
    var locationStart: CLLocationCoordinate2D = defaultCoordinate
    var locationFinish: CLLocationCoordinate2D = defaultCoordinate
    
    var prevLocation: CLLocationCoordinate2D = defaultCoordinate
    var curLocation: CLLocationCoordinate2D = defaultCoordinate
    var angle: CGFloat = 1
    
    var finalRoute = MKRoute()
    
    override func viewDidLoad() {
        activateMapAndLocationManager()
        self.showDriverData()
       
        heightMapView.constant = UIScreen.main.bounds.height

        let latitudeCenterLocation = (self.locationStart.latitude + self.locationFinish.latitude) / 2
        let longitudeCenterLocation = (self.locationStart.longitude + self.locationFinish.longitude) / 2
        let location = CLLocationCoordinate2D(latitude: latitudeCenterLocation, longitude: longitudeCenterLocation)
        
        showAnnotation(location: locationStart)
        showAnnotation(location: locationFinish)
        
        let region = MKCoordinateRegion(center: location , latitudinalMeters: finalRoute.distance, longitudinalMeters: finalRoute.distance)
        self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
        self.mapView.setNeedsDisplay()
        //draw route
        self.mapView.addOverlay(finalRoute.polyline, level: MKOverlayLevel.aboveRoads)

    }
    
    @objc func leftMenuButtonTap() {
        HamburgerMenu.triggerSideMenu()
    }
    
    @objc func reportButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func cancelButtonTap() {
        visibleView()
        self.timeToArriveView.alpha = 0
        showDriverData()
    }
    
    @objc func confirmButtonTap() {
        
        buttonView.isHidden = true
        bottomViewWithTimer.isHidden = false
        timeToArriveView.isHidden = true
        statusView.isHidden = false

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
                
                self.curLocation = self.locationFinish

                self.runDriverWaitingStopwatch(callback: { (isOk) in
                    self.statusValue.text = "Delivery status: delivered"
                    self.infoWithTimer.isHidden = true
                    self.showQRButton.isHidden = false
                    //                    if userIsSender ?? false {
                    //                        self.waitingRecipientConfirm.isHidden = false
                    //                    } else {
                    //                        self.showQRButton.isHidden = false
                    //                    }
                })
            }
        }
    }
    
    @objc func confirmRateButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ContainerViewController") as! ContainerViewController
        initialViewController.identifier = .home
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    @objc func showQRButtonTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        initialViewController.delegate = self
        self.navigationController?.pushViewController(initialViewController, animated: false)
    }
    
    
    func setCoordinate(startPoint: CLLocationCoordinate2D?, finishPoint: CLLocationCoordinate2D?, route: MKRoute?) {
        locationStart = startPoint ?? defaultCoordinate
        locationFinish = finishPoint ?? defaultCoordinate
        if let route = route {
            finalRoute = route
        }

    }
    
    //MARK: delegate CLLocationManagerDelegate functions
    fileprivate func activateMapAndLocationManager() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
    }
    
    func showDriverData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.visibleView()
            self.driverDataView.slideOut(from: .down)
            self.driverDataView.slideIn(from: .up)
            UIView.animate(withDuration: 1.5, animations: {
                self.timeToArriveView.alpha = 1.0
                self.updateFocusIfNeeded()
            }){ (isOk) in
                self.heightMapView.constant = self.view.frame.height * 0.578
            }
        }
    }
    
    func visibleView() {
        self.searhDriverView.isHidden = !self.searhDriverView.isHidden
        self.leftMenuButton.isHidden = !self.leftMenuButton.isHidden
        self.driverDataView.isHidden = !self.driverDataView.isHidden
    }
    
    func showAnnotation(location: CLLocationCoordinate2D?) {
        if let location = location {
            let locationAnnotation = MKPointAnnotation()
            locationAnnotation.coordinate = location
            self.mapView.showAnnotations([locationAnnotation], animated: true)
        }

    }
    
    func getRoutPoints(route: MKRoute, callback: @escaping (Bool) -> Void) {
        let polyline = route.polyline
        let mapPoints = polyline.points()
        
        
        var point = 1
        if polyline.pointCount == 0 { return }
        let interval: Double = 15 * 60.0 / Double(polyline.pointCount)
        let currentAnnotation = MKPointAnnotation()
        currentAnnotation.coordinate = locationStart
        
        self.mapView.addAnnotation(currentAnnotation)

        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
             self.angle = CGFloat(self.cornerTurningMarks(prevCoordinate: mapPoints[point - 1].coordinate, curCoordinate: mapPoints[point].coordinate))

            if self.curLocation.latitude != self.locationFinish.latitude && self.curLocation.longitude != self.locationFinish.longitude {
                self.curLocation = mapPoints[point].coordinate
            }
             let pinImage = UIImage(named: "annotation")

             UIView.animate(withDuration: interval, animations: {
                 currentAnnotation.coordinate =  self.curLocation
                 self.annotationView?.image =  pinImage?.rotate(radians: CGFloat(self.angle))
             }) { (isOk) in
                point += 1
            }

             if point == 0 {
                 callback(true)
             }
            if point == polyline.pointCount - 1 || (self.curLocation.latitude == self.locationFinish.latitude && self.curLocation.latitude == self.locationFinish.latitude) {
                 timer.invalidate()
             }
        }


    }
    
    
    var annotationView: MKAnnotationView?
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 0.12, green: 0.24, blue: 0.44, alpha: 1)
        renderer.lineWidth = 2.0
        
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

        if annotation.coordinate.latitude != locationStart.latitude, annotation.coordinate.longitude != locationStart.longitude,
            annotation.coordinate.latitude != locationFinish.latitude, annotation.coordinate.longitude != locationFinish.longitude {
            debugPrint(curLocation)
            let pinImage = UIImage(named: "annotation")
            annotationView?.image = pinImage?.rotate(radians: CGFloat(angle))
        } else {
            let pinImage = UIImage(named: "mark")
            annotationView?.image = pinImage
        }
        self.annotationView = annotationView
        return annotationView
    }
    
    func cornerTurningMarks(prevCoordinate: CLLocationCoordinate2D, curCoordinate: CLLocationCoordinate2D) -> Double {
        
        let differrenceLatitudeIsPositive = (curCoordinate.latitude - prevCoordinate.latitude) >= 0
        
        let xOffcetVectorA = curCoordinate.latitude - prevCoordinate.latitude
        let yOffcetVectorA = curCoordinate.longitude - prevCoordinate.longitude
        let yOffcetVectorB = curCoordinate.longitude
        
        //the formula for finding the cosine of the angle between vectors (a segment between two coordinates and a normal): cos α = (ā * ñ) / (|ā| * |ñ|)
        let cosAB = (yOffcetVectorA * yOffcetVectorB)/(sqrt(xOffcetVectorA * xOffcetVectorA + yOffcetVectorA * yOffcetVectorA) * sqrt(yOffcetVectorB * yOffcetVectorB))
        let radiusAB  = acos(cosAB)
        
        return differrenceLatitudeIsPositive ? radiusAB : -radiusAB
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
   

extension SearchDriverViewController: QRCodeViewControllerDelegate {
    func changView() {
        self.driverDataView.isHidden = true
        self.statusView.isHidden = true
        self.driverRateView.isHidden = false
        self.driverRateView.slideIn(from: .up)
    }
}
    
