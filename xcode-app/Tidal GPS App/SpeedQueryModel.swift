//
//  TidalHeightsQueryModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/20/23.
//
import Foundation
import FirebaseDatabase
import CoreLocation
import SwiftUI

struct SpeedData: Codable, Identifiable{
    // Codable is used for decoding and encoding the JSON data we get from our API call. Identifiable is used to help us make a unique identifier for our Comments object so our app can keep track of it.
    let id = UUID()
    let DateTime: String
    let SpeedInKnots: Float
}

//this tides is returning as an array!!!!!! FirebaseQueryModel().tides will return an array!

class SpeedQueryModel: ObservableObject {
    @Published var currentSpeed: [SpeedData] = []

    let ref: DatabaseReference? = Database.database().reference()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
//    var harmonicStationString: String = ""
    
    func retrieveCurrentSpeedForDisplay(observationStationString: String) {
        guard let ref = ref else {
            return
        }
        
        let databaseQuery: DatabaseQuery = ref.child(observationStationString).queryOrdered(byChild: "DateTime").queryStarting(atValue: DateTimeManagerModel().queryNow).queryEnding(atValue: DateTimeManagerModel().queryHour)
        
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
                    let speedData = try JSONSerialization.data(withJSONObject: json)
                    let speed = try self.decoder.decode(SpeedData.self, from: speedData)
                    self.currentSpeed.append(speed)
                    print(self.currentSpeed)
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
}
