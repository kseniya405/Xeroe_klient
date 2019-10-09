//
//  SearchResultTableDataSourceDelegate.swift
//  Xeroe
//
//  Created by Denis Markov on 10/9/19.
//  Copyright © 2019 Денис Марков. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

fileprivate let heightCell: CGFloat = 50
fileprivate let identifier = "ResultAddressTableViewCell"

protocol SearchResultTableDelegate {
    func chooseAddress(isStart: Bool, coordinate: MKMapItem)
}

class SearchResultTableDataSourceDelegate: NSObject, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var tableView: UITableView?
    var resultArray: [String]?
    var textField: UITextField?
    var heightTableConstraint: NSLayoutConstraint?
    var delegate: SearchResultTableDelegate?
    var isStart: Bool?
    var mapView: MKMapView?
    
    func setParameters(textField: UITextField, resultArray: [String]?, tableView: UITableView, tableHeight: NSLayoutConstraint, delegate: SearchResultTableDelegate, isStart: Bool) {
        self.tableView = tableView
        self.resultArray = resultArray
        self.textField = textField
        self.heightTableConstraint = tableHeight
        self.delegate = delegate
        self.isStart = isStart
    }
    
    func setResult(resultArray: [String]) {
        self.resultArray = resultArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentResult = resultArray {
            if currentResult.count == 0 || currentResult.count == 1, currentResult[0] == "" {
                tableView.isHidden = true
            } else {
                heightTableConstraint?.constant = CGFloat(currentResult.count) * heightCell
                tableView.isHidden = false
            }
            return currentResult.count
        }
        tableView.isHidden = true
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ResultAddressTableViewCell
        
        if let result = resultArray, indexPath.row < result.count {
            cell.setParameters(address: result[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ResultAddressTableViewCell
        textField?.text = cell.addressLabel.text
        resultArray?.removeAll()
        tableView.isHidden = true
        if let address = textField?.text {
            convertAddressToCoordinate(from: address) { (location) in
                self.delegate?.chooseAddress(isStart: self.isStart ?? true, coordinate: self.setMapItem(location: location))
            }
        }
        
    }
    
    func convertAddressToCoordinate(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D)-> Void) {
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
        self.mapView?.showAnnotations([locationAnnotation], animated: true)
        return locationMapItem
    }
    

}
