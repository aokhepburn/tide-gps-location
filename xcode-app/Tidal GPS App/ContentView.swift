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
    
    //💥💥💥💥💥 Add functionality to this boolean please
    @State var isFlooding: Bool = true
    
    @State var speedStationChoice: String = "SPEEDTheNarrows(n03020)LAT406064LON-740380"
    
    
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
            
            //💥💥💥💥💥 Add functionality to this boolean please
            Text(isFlooding ? "Flood" : "Ebb")
            TidalHeightView()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //💥💥💥💥💥 Picker is not setting speedStationChoicePicked - decide what to do QUICKLY. Do not get bogged down use a default as a one example if necessary.
            Picker("Select a station", selection: $speedStationChoice) {
                    Text("TheNarrows").tag("SPEEDTheNarrows(n03020)LAT406064LON-740380")
                    Text("Robbins Reef Light").tag("SPEEDRobbinsReefLight(NYH1915)LAT406552LON-740507")
                    Text("Red Hook Channel").tag("SPEEDRedHookChannel(NYH1918)LAT406723LON-740239")
                    Text("Newtown Creek").tag("SPEEDNewtownCreek(NYH1922)LAT407347LON-739657")
                    Text("Pier 92").tag("SPEEDHudsonRiverPier92(NYH1928)LAT407707LON-740028")
                    Text("Hell Gate").tag("SPEEDHellGate(NYH1924)LAT407783LON-739383")
                    Text("Gowanus Flats").tag("SPEEDGowanusFlats(n05010)LAT406721LON-740399")
                    Text("Gowanus Bay").tag("SPEEDGowanusBay(NYH1917)LAT406625LON-740181")
                    Text("George Washington Bridge").tag("SPEEDGeorgeWashingtonBridge(HUR0611)LAT408496LON-739498")
                    Text("Diamond Reef").tag("SPEEDDiamondReef(NYH1919)LAT406979LON-740213")
                //currently commented out as pickers only allow 10 choices and I can eliminate a few of the others instead as being outside of scope
//                        Text("Corlears Hook").tag("SPEEDCorlearsHook(NYH1921)LAT407095LON-739764")
//                        Text("Constable Hook Approach").tag("SPEEDConstableHookApproach(NYH1914)LAT406507LON-740606")
//                        Text("Brooklyn Bridge").tag("SPEEDBrooklynBridge(NYH1920)LAT407060LON-739977")
//                        Text("Ambrose Channel").tag("SPEEDAmbroseChannel(NYH1903)LAT405167LON-739747")
                  }
                  .pickerStyle(.wheel)
            
            CurrentSpeedView(speedStationChoicePicked: speedStationChoice)
        }
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
