//
//  SpeedQueryView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/20/23.
//

import Foundation
import SwiftUI

struct SpeedQueryView: View{
    @EnvironmentObject var speedQueryModel: SpeedQueryModel
    
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
    
    @State var speedStationChoice: String = "SPEEDHudsonRiverEntrance(NYH1927)LAT4070760LON-7402530"
    
    var body: some View {
        VStack{
            Picker("Speed Station Selection", selection: $speedStationChoice, content: {
                ForEach(stationChoices, id: \.self, content: { station in // <1>
                    Text(station)
                })
            })
            .pickerStyle(.menu)
            .onChange(of: speedStationChoice) { _ in
                speedQueryModel.retrieveCurrentSpeedForDisplay(observationStationString: speedStationChoice)
                print(speedStationChoice)
                    }
                List(speedQueryModel.currentSpeed) {speed in
                    HStack(alignment: .center) {
                        Text(speed.DateTime)
                            .foregroundColor(Color(.gray))
                        Spacer()
                        Text(String(speed.SpeedInKnots))
                            .fontWeight(.bold)
                        Text("speed in knots")
                            .foregroundColor(Color(.gray))
                        
                    }
                }
                .frame(maxHeight: 65)
                .padding(10)
            }
    }
}
//    //💥💥💥💥💥 Picker is not setting speedStationChoicePicked - decide what to do QUICKLY. Do not get bogged down use a default as a one example if necessary.
//    
////    @State var speedStationChoicePicked: String
//    @EnvironmentObject var speedQueryModel: SpeedQueryModel
//    
//    var body: some View {
//            VStack{
//                Text("Speed In Knots")
//                List(speedQueryModel.currentSpeed) {speed in
//                    HStack(alignment: .center) {
//                        Text(speed.DateTime)
//                        Spacer()
//                        Text(String(speed.SpeedInKnots))
//                            .fontWeight(.bold)
//
//                    }
//                }
//                .frame(maxHeight: 50)
//                .refreshable {
//                    <#code#>
//                }
//            }
//        }
//    }

