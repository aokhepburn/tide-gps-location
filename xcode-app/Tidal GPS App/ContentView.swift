//
//  ContentView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/5/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI
import MapKit

struct PairView: View {
    let leftText: String
    let rightText: String
    
    var body: some View {
        HStack {
            Text(leftText)
            Spacer()
            Text(rightText)
        }
    }
}

//ContentView is doing heavy lifting of checking permissions, first step.
struct ContentView: View {
    @StateObject var locationManagerModel = LocationManagerModel()
    var body: some View {
        switch locationManagerModel.authorizationStatus{
        case .authorizedWhenInUse, .authorizedAlways:
            TrackingView()
                .environmentObject(locationManagerModel)
        case .denied:
            PairView(
                leftText: "ERROR", rightText: "User denied permission to location data.")
        case .restricted:
            PairView(leftText: "ERROR", rightText: "User has restricted access to location data.")
        case .notDetermined:
            AnyView(RequestLocationView())
                .environmentObject(locationManagerModel)
        default: Text("Unexpected Status is default response")
        }
    }
}

//landing page where we ask for permissions
struct RequestLocationView: View{
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    
    var body: some View{
        VStack{
            //systemImage is from SF symbols catalogue
            Image(systemName: "figure.sailing")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.cyan)
            Button(action: {
                locationManagerModel.requestPermission()
            }, label: {
                Label("Allow tracking", systemImage: "location")
            })
            .padding(10)
            .foregroundColor(.white)
            .background(Color.pink)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            Text("Get started by allowing us permission to track your GPS location.")
                .foregroundColor(.accentColor)
                .font(.caption)
        }
        
    }
}

//Main view page with map and printed coordinate & tide information
struct TrackingView: View {
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    @StateObject var dateTime = DateTimeManagerModel()
    @StateObject private var viewModel = FirebaseQueryModel()
    var coordinate: CLLocationCoordinate2D? {
        locationManagerModel.lastSeenLocation?.coordinate
    }
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.70565231462143, longitude: -74.00502341810812), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 0.5))
    
    let annotations = [
        City(name: "King's Point", coordinate: CLLocationCoordinate2D(latitude: 40.810299, longitude: -73.764900)),
        City(name: "The Battery", coordinate: CLLocationCoordinate2D(latitude: 40.700556, longitude: -74.014167)),
        City(name: "Sandy Hook", coordinate: CLLocationCoordinate2D(latitude: 40.4583315, longitude: -74.00166666)),
        City(name: "Bergen Point West Reach", coordinate: CLLocationCoordinate2D(latitude: 40.6391, longitude: -74.146306))
    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: annotations) {
                        MapMarker(coordinate: $0.coordinate)
                    }
                        .frame(width: 400, height: 300)
                
                PairView(
                    leftText: "Latitude:",
                    rightText: String(coordinate?.latitude ?? 0)
                )
                PairView(
                    leftText: "Longitude:",
                    rightText: String(coordinate?.longitude ?? 0)
                )
                PairView(
                    leftText: "Date & Time (For Display:",
                    rightText: String(dateTime.displayNow!))
                .padding(10)
            
            
            List(viewModel.tides) {tide in
                VStack(alignment: .leading) {
                    Text(tide.t)
                        .font(.title)
                        .fontWeight(.bold)
                    PairView(
                        leftText: "height from Mean Lower Low Water",
                        rightText: tide.v
                    )
                }
            }
                Button {
                    Task {
                        if Float(coordinate?.latitude ?? 0) < 40.6526 && Float(coordinate?.latitude ?? 0) > 40.5949 && Float(coordinate?.longitude ?? 0) > -74.2035 && Float(coordinate?.longitude ?? 0) < -74.1088 {
                            viewModel.harmonicStationString = "west-bergen"
                            viewModel.listentoRealtimeDatabase()
                        } else if Float(coordinate?.latitude ?? 0) < 40.9607 && Float(coordinate?.latitude ?? 0) > 40.7544 && Float(coordinate?.longitude ?? 0) > -73.9092 && Float(coordinate?.longitude ?? 0) < -73.6116 {
                            viewModel.harmonicStationString = "kings-point"
                            viewModel.listentoRealtimeDatabase()
                        } else if Float(coordinate?.latitude ?? 0) < 40.8511 && Float(coordinate?.latitude ?? 0) > 40.6009 && Float(coordinate?.longitude ?? 0) > -74.1088 && Float(coordinate?.longitude ?? 0) < -73.9092 {
                            viewModel.harmonicStationString = "the-battery"
                            viewModel.listentoRealtimeDatabase()
                        }
                        
                    }
                } label: {
                    Text("Fetch Tide")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
