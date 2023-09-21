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
    @EnvironmentObject var speedQueryModel: SpeedQueryModel
    @EnvironmentObject var tidalHeightsQueryModel: TidalHeightsQueryModel
    var coordinateLatitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.latitude ?? 0}
    var coordinateLongitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.longitude ?? 0}
    @State var showSheetView = false
    
    
    //💥💥💥💥💥 Add functionality to this boolean please
    
    private var stationChoices = ["SPEEDAmbroseChannel(NYH1903)LAT405167LON-739747",
                                  "SPEEDBrooklynBridge(NYH1920)LAT407060LON-739977",
                                  "SPEEDConstableHookApproach(NYH1914)LAT406507LON-740606",
                                  "SPEEDCorlearsHook(NYH1921)LAT407095LON-739764",
                                  "SPEEDDiamondReef(NYH1919)LAT406979LON-740213",
                                  "SPEEDGeorgeWashingtonBridge(HUR0611)LAT408496LON-739498",
                                  "SPEEDGowanusBay(NYH1917)LAT406625LON-740181",
                                  "SPEEDGowanusFlats(n05010)LAT406721LON-740399",
                                  "SPEEDHellGate(NYH1924)LAT407783LON-739383",
                                  "SPEEDHudsonRiverEntrance(NYH1927)LAT4070760LON-7402530",
                                  "SPEEDHudsonRiverPier92(NYH1928)LAT407707LON-740028",
                                  "SPEEDNewtownCreek(NYH1922)LAT407347LON-739657",
                                  "SPEEDRedHookChannel(NYH1918)LAT406723LON-740239",
                                  "SPEEDRobbinsReefLight(NYH1915)LAT406552LON-740507",
                                  "SPEEDTheNarrows(n03020)LAT406064LON-740380]"]
    
    @State var speedStationChoice = "SPEEDRobbinsReefLight(NYH1915)LAT406552LON-740507"
    
    
    //main map view
    var body: some View {
        VStack {
            MapView()
                .frame(maxHeight: .infinity, alignment: .leading)
                .edgesIgnoringSafeArea(.top)

            VStack{
                //💥💥💥💥💥 Add functionality to this boolean please
                //                Text(isFlooding ? "Flood" : "Ebb")
                TidalHeightView()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .task {tidalHeightsQueryModel.retrieveTidesForDisplay(latitude: coordinateLatitude, longitude: coordinateLongitude)
                    }
                
                VStack{
//                    NavigationLink(destination: EldridgeView()) {
//                        Text("Hello, World!")
//                    }
//                    .navigationTitle("Navigation")
                    
                    Picker("Speed Station Selection", selection: $speedStationChoice, content: {
                        ForEach(stationChoices, id: \.self, content: { station in // <1>
                            Text(station)
                        })
                    })
                    //                CurrentSpeedView()
                    VStack{
                        List(speedQueryModel.currentSpeed) {speed in
                            HStack(alignment: .center) {
                                Text(speed.DateTime)
                                Spacer()
                                Text(String(speed.SpeedInKnots))
                                    .fontWeight(.bold)
                                Text("speed in knots")
                                
                            }
                        }
                        .frame(maxHeight: 50)
                        .refreshable {
                            speedQueryModel.retrieveCurrentSpeedForDisplay(observationStationString: speedStationChoice)
                            print(speedStationChoice)
                        }
                    }
                    Button {
                        Task {
                            speedQueryModel.retrieveCurrentSpeedForDisplay(observationStationString: speedStationChoice)
                            print(speedStationChoice)
                        }
                    }label: {
                        Text("Fetch Current Speed")
                    }
                    
                }
                //                FloodEbbSlackView()
            }
        }
    }
}
                       
    
    
    struct EldridgeView: View{
        var body: some View{
            VStack{
                Text("will this work")
            }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
