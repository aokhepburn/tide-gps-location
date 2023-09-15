//
//  AnnotationsModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/15/23.
//

import Foundation
import CoreLocation

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
