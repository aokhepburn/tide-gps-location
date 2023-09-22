//
//  TidalHeightsQueryModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/18/23.
//
import Foundation
import FirebaseDatabase
import CoreLocation
import SwiftUI

struct TidalData: Codable, Identifiable{
    // Codable is used for decoding and encoding the JSON data we get from our API call. Identifiable is used to help us make a unique identifier for our Comments object so our app can keep track of it.
    let id = UUID()
    let DateTime: String
    let Prediction: Float
}

//this tides is returning as an array!!!!!! FirebaseQueryModel().tides will return an array!

class TidalHeightsQueryModel: ObservableObject {
    @Published var tidesForDisplay: [TidalData] = []
    var isFlooding: Bool = false
//    @State var isEbbing: Bool = false

    var ref: DatabaseReference? = Database.database().reference()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var harmonicStationString: String = ""
    
    func retrieveTidesForDisplay(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.tidesForDisplay.removeAll()
        //ferry route coordinates 40.70041870860205, -74.02376216255963
        if Float(latitude) < 40.66912 && Float(latitude) > 40.587279 && Float(longitude) > -74.10612 && Float(longitude) < -73.98512 {
                harmonicStationString = "HEIGHTUSCGStation(8519050)LAT4060194LON-7405167"
            } else if Float(latitude) < 40.6526 && Float(latitude) > 40.5949 && Float(longitude) > -74.2035 && Float(longitude) < -73.994623 {
                harmonicStationString = "HEIGHTBergenPointWestReach(8519483)LAT40634167LON-7413556"
            } else if Float(latitude) < 40.76357 && Float(latitude) > 40.66912 && Float(longitude) > -74.08729 && Float(longitude) < -74.00076 {harmonicStationString = "HEIGHTTheBattery(8518750)LAT407LON-740025"
            } else if Float(latitude) < 40.715242 && Float(latitude) > 40.698782 && Float(longitude) > -74.00076 && Float(longitude) < -73.97496 {harmonicStationString = "HEIGHTBrooklynBridge(8517847)LAT4070056LON-73985278"
            } else if Float(latitude) < 40.724971 && Float(latitude) > 40.715242 && Float(longitude) > -73.97496 && Float(longitude) < -73.95743923 {
                harmonicStationString = "HEIGHTWilliamsburgBridge(8518699)LAT4070194LON-7396694"
            } else if Float(latitude) < 40.76799432232893 && Float(latitude) > 40.724971 && Float(longitude) > -73.96356351064199 && Float(longitude) < -73.93889 {harmonicStationString = "HEIGHTQueensboroBridge(8518687)LAT40751389LON-7395138"
            } else if Float(latitude) < 40.78572 && Float(latitude) > 40.767994322 && Float(longitude) > -73.95206 && Float(longitude) < -73.91717 {
                harmonicStationString = "HEIGHTHornsHook(8518668)LAT407683LON-7393472"
            } else if Float(latitude) < 40.80288 && Float(latitude) > 40.78572 && Float(longitude) > -73.94521 && Float(longitude) < -73.91112 {
                harmonicStationString = "HEIGHTRandallsIsland(8518643)LAT408LON-7391861"
            } else if Float(latitude ) < 40.827655 && Float(latitude ) > 40.78572 && Float(longitude ) > -73.91112 && Float(longitude ) < -73.80903 {
                harmonicStationString = "HEIGHTPortMorris(8518639)LAT40800278LON-739011"
            } else if Float(latitude) < 40.78572 && Float(latitude) > 40.7457166 && Float(longitude) > -73.8739028 && Float(longitude) < -73.831424 {
                harmonicStationString = "HEIGHTWorldsFairMarina(8517251)LAT4075194LON-7385"
            }
        
        guard let ref = ref else {
            return
        }
        
        let databaseQuery: DatabaseQuery = ref.child(harmonicStationString).queryOrdered(byChild: "DateTime").queryStarting(atValue: DateTimeManagerModel().queryNow).queryEnding(atValue: DateTimeManagerModel().queryHour)
        
        databaseQuery
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                json["id"] = snapshot.key
                do {
                    let tideData = try JSONSerialization.data(withJSONObject: json)
                    let tide = try self.decoder.decode(TidalData.self, from: tideData)
                    //print(type(of: tide))
                    self.tidesForDisplay.append(tide)
                    print("db thing")
                    //print(harmonicStationString)
                    //print(self.tidesForDisplay)
                    //setFloodSlackEbb()
//                    if self.tidesForDisplay[0].Prediction < 0 {isFlooding = true
//                                isEbbing = false
//                            } else {isFlooding = false
//                                isEbbing = true}
                } catch {
                    print("an error occurred", error)
                }
//                print(self)
                
            }

    }
    func setFloodSlackEbb()-> String{
        let count = self.tidesForDisplay.count
        if(count > 0){
            print("test")
//            self.isFlooding = true
            if self.tidesForDisplay[0].Prediction < self.tidesForDisplay[count-1].Prediction {self.isFlooding = true
            } else {self.isFlooding = false}
        }
        //
        print(self.isFlooding)
        print(self.tidesForDisplay.count)
        if self.isFlooding == true {
            return "Flood"
        } else {return "Ebb"}
    }
    func stopListening() {
        ref?.removeAllObservers()
    }
    
//    func setFloodSlackEbb(){
//        if self.tidesForDisplay[0].Prediction < self.tidesForDisplay[1].Prediction && self.tidesForDisplay[1].Prediction < self.tidesForDisplay[2].Prediction {isFlooding = true
//            isEbbing = false
//        } else {isFlooding = false
//            isEbbing = true}
//    }
}
