//
//  MapVC.swift
//  pixel-city
//
//  Created by Umut Ağbaba on 15.03.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var pullUpView: UIView!
    
    @IBOutlet weak var pullUpHeightConst: NSLayoutConstraint!
    
    var locationManager = CLLocationManager()
    
    let authStatus = CLLocationManager().authorizationStatus
    
    let regionRadius: Double = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        configureLocationServices()
        addDoubleTap()
    }

    func addDoubleTap(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(dropPin(sender: )))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func animateViewUp(){
        pullUpHeightConst.constant = 300
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func mapLocationTapped(_ sender: Any) {
        if authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        pinAnnotation.pinTintColor = UIColor.orange
        pinAnnotation.animatesDrop = true
        return pinAnnotation
    }
    
    func centerMapOnUserLocation(){
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius * 2.0 , longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func dropPin(sender: UITapGestureRecognizer) {
        removePin()
        animateViewUp()
        
        let touchPoint = sender.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegion(center: touchCoordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices(){
        if authStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        centerMapOnUserLocation()
    }
}
