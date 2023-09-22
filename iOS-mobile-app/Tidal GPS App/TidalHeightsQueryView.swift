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
    var coordinateLatitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.latitude ?? 0}
    var coordinateLongitude: CLLocationDegrees {locationManagerModel.lastSeenLocation?.coordinate.longitude ?? 0}
    @EnvironmentObject private var tidalHeightsQueryModel: TidalHeightsQueryModel
    @EnvironmentObject var dateTimeManagerModel: DateTimeManagerModel
//    var flood: Bool =

    var body: some View {
        VStack{
            HStack{
                //fake for now
                Text("it is a ")
                    .foregroundColor(Color(.gray))
                Text(tidalHeightsQueryModel.setFloodSlackEbb())
                    .fontWeight(.bold)
                Text("at NOAA Station")
                    .foregroundColor(Color.gray)
                Text(tidalHeightsQueryModel.harmonicStationString)
            }
            List(tidalHeightsQueryModel.tidesForDisplay) {tide in
                HStack(alignment: .center) {
                    Text(tide.DateTime)
                        .foregroundColor(Color(.gray))
                    Spacer()
                    Text(String(tide.Prediction))
                        .fontWeight(.bold)
                        .frame(maxWidth: 150)
                    Spacer()
                    Text("ft. from from low water")
                        .foregroundColor(Color(.gray))
                }
            }
                .refreshable {
                    tidalHeightsQueryModel.retrieveTidesForDisplay(latitude: coordinateLatitude, longitude: coordinateLongitude)
                    
                }
            .frame(maxHeight: 50)
        }
    }
}
