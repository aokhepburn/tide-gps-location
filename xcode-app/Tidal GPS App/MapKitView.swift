//
//  MapKitViewModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/18/23.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation

struct Stations: Identifiable{
    let id = UUID()
    let name: String?
    let kind: String?
    let coordinate: CLLocationCoordinate2D
    //station.speed
}

struct MapView: View {
//    @EnvironmentObject var speedQueryModel: SpeedQueryModel
        //?????write a forEach statement that calls for each station below? enh something. another fetch method that calls on each of the speed stations and prints to the new array Stations
    
    @State private var stationAnnotations: [Stations] = [
//        Stations(name: "Randall's Island", kind: "Height Of Water Level", coordinate: CLLocationCoordinate2D(latitude: 40.8, longitude: -73.91861)),
//        Stations(name: "World's Fair Arena", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.75194, longitude: -73.85)),
//        Stations(name: "Port Morris", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.800278, longitude: -73.9011)),
//        Stations(name: "Horn's Hook", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.7683, longitude: -73.93472)),
//        Stations(name: "Queensboro Bridge", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.751389, longitude:-73.95138)),
//        Stations(name: "Williamsburg Bridge", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.70194, longitude:-73.96694)),
//        Stations(name: "Brooklyn Bridge", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.70056, longitude:-73.985278)),
//        Stations(name: "Bergen Point West Reach", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.634167, longitude:-74.13556)),
//        Stations(name: "USCG Station", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.60194, longitude:-74.05167)),
//        Stations(name: "TheBattery", kind: "Height Of Water Level", coordinate:CLLocationCoordinate2D(latitude: 40.7, longitude:-74.0025)),
        Stations(name: "Hell Gate", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.7783, longitude:-73.9383)),
        Stations(name: "Brooklyn Bridge", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.7060, longitude:-73.9977)),
        Stations(name: "Corlear's Hook", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.7095, longitude:-73.9764)),
        Stations(name: "Newtown Creek", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.7347, longitude:-73.9657)),
        Stations(name: "Diamond Reef", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6979, longitude:-74.0213)),
        Stations(name: "Gowanus Flats", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6721, longitude:-74.0399)),
        Stations(name: "Constable Hook Approach", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6507, longitude: -74.0606)),
        Stations(name: "Robbins Reef Light", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6552, longitude:-74.0507)),
        Stations(name: "Red Hook Channel", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6723, longitude:-74.0239)),
        Stations(name: "Gowanus Bay", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6625, longitude: -74.0181)),
        Stations(name: "Hudson River Pier 92", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.7707, longitude:-74.0028)),
        Stations(name: "George Washington Bridge", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.8496, longitude:-73.9498)),
        Stations(name: "Ambrose Channel", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.5167, longitude:-73.9747)),
        Stations(name: "The Narrows", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.6064, longitude:-74.0380)),
        Stations(name: "Hudson River Entrance", kind: "Current Speed", coordinate:CLLocationCoordinate2D(latitude: 40.70760, longitude:-74.02530))
    ]
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.70565231462143, longitude: -74.00502341810812), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    
    var body: some View {
        Map(
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: stationAnnotations) {annotationItem in MapAnnotation(coordinate: annotationItem.coordinate){
                VStack{
                    Group{
                        Image(systemName: "map.circle.fill")
                            .resizable()
                            .frame(width:10.0, height: 10.0)
                        Text(annotationItem.name!)
                            .font(.system(size: 10))
                            .frame(width:50)
                    }
                }
            }
            }
    }
}
