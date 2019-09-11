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


class SearchDriverViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var leftMenuButton: UIButton! {
        didSet {
            leftMenuButton.addTarget(self, action: #selector(leftMenuButtonTap), for: .touchUpInside)
        }
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
      
        
        // 1.ViewController - делегат протокола MKMapViewDelegate;
        mapView.delegate = self
        
        // 2.Установите широту и долготу местоположений;
        let sourceLocation = CLLocationCoordinate2D(latitude: 51.5207722, longitude: -0.1221087)
        let destinationLocation = CLLocationCoordinate2D(latitude: 51.587996, longitude: -0.165222)
        
        // 3.Создайте объекты - метки, содержащие метки координаты местоположения;
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)

        // 4.MKMapitems используются для маршрутизации. Этот класс инкапсулирует информацию о конкретной точке на карте;
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5.Добавляются аннотации, которые отображают названия меток;
        let sourceAnnotation = MKPointAnnotation()
  //      sourceAnnotation.title = "Times Square"

        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate

        }

        let destinationAnnotation = MKPointAnnotation()
//        destinationAnnotation.title = "Empire State Building"

        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate

        }


        
        // 7.Класс MKDirectionsRequest используется для вычисления маршрута;
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.Маршрут будет нарисован с использованием полилинии по наложенному на карту верхнему слою. Область установлена, поэтому будут видны обе локации;
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
        
            let location = CLLocationCoordinate2D(latitude: 51.5543841 * 0.9995, longitude: -0.143150)
            let region = MKCoordinateRegion(center: location , latitudinalMeters: CLLocationDistance(exactly: 10000)!, longitudinalMeters: CLLocationDistance(exactly: 10000)!)
            // 6.Аннотации отображаются на карте;
            self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
            self.mapView.setRegion(self.mapView.regionThatFits(region), animated: true)
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)

        }
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
    


}


