//
//  SpeedQueryView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/20/23.
//

import Foundation
import SwiftUI

struct CurrentSpeedView: View{
    //💥💥💥💥💥 Picker is not setting speedStationChoicePicked - decide what to do QUICKLY. Do not get bogged down use a default as a one example if necessary.
    
    @State var speedStationChoicePicked: String
    @EnvironmentObject var speedQueryModel: SpeedQueryModel
    
    var body: some View {
        VStack{
            List(speedQueryModel.currentSpeed) {speed in
                HStack(alignment: .center) {
                    Text(speed.DateTime)
                        .fontWeight(.bold)
                    Spacer()
                    Text(String(speed.SpeedInKnots))
                        .fontWeight(.bold)
                    
                }
            }
            
            Button {
                //                passing right query for fetch
                Task {
                    speedQueryModel.retrieveCurrentSpeedForDisplay(observationStationString: speedStationChoicePicked)
                    print(speedStationChoicePicked)
                }
            }label: {
                Text("Current Speed")
            }
        }
        }
}

