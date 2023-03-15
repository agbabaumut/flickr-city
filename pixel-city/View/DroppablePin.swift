//
//  DroppablePin.swift
//  pixel-city
//
//  Created by Umut Ağbaba on 15.03.2023.
//

import UIKit
import MapKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String
    
    init(coordinate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordinate
        self.identifier = identifier
    }
}
