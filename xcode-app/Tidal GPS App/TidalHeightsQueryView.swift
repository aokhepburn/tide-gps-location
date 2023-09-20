//
//  TidalHeightsQueryView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/20/23.
//

import Foundation
import SwiftUI
import CoreLocation

struct TidalHeightView: View {
    @EnvironmentObject var locationManagerModel: LocationManagerModel
    var coordinate: CLLocationCoordinate2D? {
        locationManagerModel.lastSeenLocation?.coordinate
    }
    @EnvironmentObject private var tidalHeightsQueryModel: TidalHeightsQueryModel
    @EnvironmentObject var dateTimeManagerModel: DateTimeManagerModel
    //just making a quick var for ease of reference to coordinates
    
    
    var body: some View {
        VStack{
            List(tidalHeightsQueryModel.tidesForDisplay) {tide in
                HStack(alignment: .center) {
                    Text(tide.DateTime)
                        .fontWeight(.bold)
                    Spacer()
                    Text(String(tide.Prediction))
                        .fontWeight(.bold)
                    
                }
            }
            Button {
                //                passing right query for fetch
                Task {
                    if Float(coordinate?.latitude ?? 0) < 40.66912 && Float(coordinate?.latitude ?? 0) > 40.587279 && Float(coordinate?.longitude ?? 0) > -74.10612 && Float(coordinate?.longitude ?? 0) < -73.98512 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTUSCGStation(8519050)LAT4060194LON-7405167")
                    } else if Float(coordinate?.latitude ?? 0) < 40.6526 && Float(coordinate?.latitude ?? 0) > 40.5949 && Float(coordinate?.longitude ?? 0) > -74.2035 && Float(coordinate?.longitude ?? 0) < -73.994623 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTBergenPointWestReach(8519483)LAT40634167LON-7413556")
                    } else if Float(coordinate?.latitude ?? 0) < 40.76357 && Float(coordinate?.latitude ?? 0) > 40.66912 && Float(coordinate?.longitude ?? 0) > -74.08729 && Float(coordinate?.longitude ?? 0) < -74.00076 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTTheBattery(8518750)LAT407LON-740025")
                    } else if Float(coordinate?.latitude ?? 0) < 40.715242 && Float(coordinate?.latitude ?? 0) > 40.698782 && Float(coordinate?.longitude ?? 0) > -74.00076 && Float(coordinate?.longitude ?? 0) < -73.97496 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTBrooklynBridge(8517847)LAT4070056LON-73985278")
                    } else if Float(coordinate?.latitude ?? 0) < 40.724971 && Float(coordinate?.latitude ?? 0) > 40.715242 && Float(coordinate?.longitude ?? 0) > -73.97496 && Float(coordinate?.longitude ?? 0) < -73.95743923 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTWilliamsburgBridge(8518699)LAT4070194LON-7396694")
                    } else if Float(coordinate?.latitude ?? 0) < 40.76799432232893 && Float(coordinate?.latitude ?? 0) > 40.724971 && Float(coordinate?.longitude ?? 0) > -73.96356351064199 && Float(coordinate?.longitude ?? 0) < -73.93889 {tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTQueensboroBridge(8518687)LAT40751389LON-7395138")
                    } else if Float(coordinate?.latitude ?? 0) < 40.78572 && Float(coordinate?.latitude ?? 0) > 40.767994322 && Float(coordinate?.longitude ?? 0) > -73.95206 && Float(coordinate?.longitude ?? 0) < -73.91717 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTHornsHook(8518668)LAT407683LON-7393472")
                    } else if Float(coordinate?.latitude ?? 0) < 40.80288 && Float(coordinate?.latitude ?? 0) > 40.78572 && Float(coordinate?.longitude ?? 0) > -73.94521 && Float(coordinate?.longitude ?? 0) < -73.91112 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTRandallsIsland(8518643)LAT408LON-7391861")
                    } else if Float(coordinate?.latitude ?? 0) < 40.827655 && Float(coordinate?.latitude ?? 0) > 40.78572 && Float(coordinate?.longitude ?? 0) > -73.91112 && Float(coordinate?.longitude ?? 0) < -73.80903 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTPortMorris(8518639)LAT40800278LON-739011")
                    } else if Float(coordinate?.latitude ?? 0) < 40.78572 && Float(coordinate?.latitude ?? 0) > 40.7457166 && Float(coordinate?.longitude ?? 0) > -73.8739028 && Float(coordinate?.longitude ?? 0) < -73.831424 {
                        tidalHeightsQueryModel.retrieveTidesForDisplay(harmonicStationString: "HEIGHTWorldsFairMarina(8517251)LAT4075194LON-7385")
                    }
                }
            }label: {
                Text("Fetch Tide")
            }
        }
    }
}
