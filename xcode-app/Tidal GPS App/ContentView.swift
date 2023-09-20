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
    @StateObject var tidalHeightsQueryModel = TidalHeightsQueryModel()
    @StateObject var dateTimeManagerModel = DateTimeManagerModel()
    
    var body: some View {
        switch locationManagerModel.authorizationStatus{
        case .authorizedWhenInUse, .authorizedAlways:
            TrackingView()
                .environmentObject(locationManagerModel)
                .environmentObject(tidalHeightsQueryModel)
                .environmentObject(dateTimeManagerModel)
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
    //gps location
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    //date information
    @EnvironmentObject var dateTimeManagerModel: DateTimeManagerModel
    //data for tidal heights and fetch request for data
//    @EnvironmentObject private var tidalHeightsQueryModel: TidalHeightsQueryModel
    //just making a quick var for ease of reference to coordinates
    var coordinate: CLLocationCoordinate2D? {
        locationManagerModel.lastSeenLocation?.coordinate
    }
    
    @State var isFlooding: Bool = true
    
    
    //main map view
    var body: some View {
        VStack {
            MapView()
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
                rightText: String(dateTimeManagerModel.displayNow!))
            .padding(10)
            
            Text(isFlooding ? "Flood" : "Ebb")
            TidalHeightView()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
