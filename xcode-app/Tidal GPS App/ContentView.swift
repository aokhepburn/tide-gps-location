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
//To always get RequestLocationView reorganise so that is higher in these switch cases

struct ContentView: View {
    @StateObject var locationManagerModel = LocationManagerModel()
    @StateObject var tidalHeightsQueryModel = TidalHeightsQueryModel()
    @StateObject var dateTimeManagerModel = DateTimeManagerModel()
    @StateObject var speedQueryModel = SpeedQueryModel()
    
    var body: some View {
//        RequestLocationView()
        switch locationManagerModel.authorizationStatus{
        case .authorizedWhenInUse, .authorizedAlways:
            TrackingView()
                .environmentObject(locationManagerModel)
                .environmentObject(tidalHeightsQueryModel)
                .environmentObject(dateTimeManagerModel)
                .environmentObject(speedQueryModel)
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
                Text("Welcome to")
                    .foregroundColor(.pink)
                Text("TideNY")
                    .fontWeight(.bold)
                    .fontWidth(.expanded)
                    .foregroundColor(.pink)
                    .padding(5)
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
                .foregroundColor(.cyan)
                .font(.caption)
                .padding(10)
        }
        
    }
}

//Main view page with map and printed coordinate & tide information
struct TrackingView: View {
    //gps location
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    //date information
    @EnvironmentObject var dateTimeManagerModel: DateTimeManagerModel
    //just making a quick var for ease of reference to coordinates
    var coordinate: CLLocationCoordinate2D? {
        locationManagerModel.lastSeenLocation?.coordinate
    }
    @EnvironmentObject var tidalHeightsQueryModel: TidalHeightsQueryModel
    var coordinateLatitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.latitude ?? 0}
    var coordinateLongitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.longitude ?? 0}
    
    @EnvironmentObject var speedQueryModel: SpeedQueryModel
    
    //💥💥💥💥💥 Add functionality to this boolean please
    
    //main map view
    var body: some View {
        VStack {
            MapView()
                .frame(maxHeight: .infinity, alignment: .leading)
                .edgesIgnoringSafeArea(.top)
            
            //💥💥💥💥💥 Add functionality to this boolean please
            //                Text(isFlooding ? "Flood" : "Ebb")
            TidalHeightView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .task {tidalHeightsQueryModel.retrieveTidesForDisplay(latitude: coordinateLatitude, longitude: coordinateLongitude)
                }
            SpeedQueryView()
                .task{speedQueryModel.retrieveCurrentSpeedForDisplay(observationStationString: "SPEEDHudsonRiverEntrance(NYH1927)LAT4070760LON-7402530")}
            
        }
        }
    }


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

