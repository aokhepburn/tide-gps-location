//
//  ContentView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/5/23.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

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

//This function will have to be transformed to set the coordinates as varibles that can be used as inputs
struct TrackingView: View {
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    
    var body: some View {
        VStack {
            VStack {
                PairView(
                    leftText: "Latitude:",
                    rightText: String(coordinate?.latitude ?? 0)
                )
                PairView(
                    leftText: "Longitude:",
                    rightText: String(coordinate?.longitude ?? 0)
                )
            }
            .padding()
        }
    }
    
    var coordinate: CLLocationCoordinate2D? {
        locationManagerModel.lastSeenLocation?.coordinate
    }
}

//extension ContentView {
//    final class ViewModel: ObservableObject {
//        let items: [Item] = [
//            Item(name: "Hello"),
//            Item(name: "World"),
//            Item(name: "Whey Hey"),
//            Item(name: "We are working now!"),
//            Item(name: "See Daniel")
//        ]
//        func select(_: ContentView.Item) {
//            // implement
//        }
//    }
//    struct Item: Identifiable {
//        let name: String
//        var id: String { name }
//    }
//}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
