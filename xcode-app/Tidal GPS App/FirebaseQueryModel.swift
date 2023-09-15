//
//  FirebaseQueryModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/14/23.
//

import Foundation
import FirebaseDatabase
import CoreLocation

//this tides is returning as an array!!!!!! FirebaseQueryModel().tides will return an array!

class FirebaseQueryModel: ObservableObject {
    @Published var tides: [TidalData] = []

    let ref: DatabaseReference? = Database.database().reference()
    
    //        return nowTides
//    private lazy var databasePath: DatabaseQuery? = {
//        let ref = Database.database().reference().child("kingspoint-921-924-predictions")
//        let nowTides = ref.queryOrdered(byChild: "t").queryEqual(toValue: "2023-09-21 00")
//        return nowTides
//    }()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var harmonicStationString: String = "the-battery"
    
    func listentoRealtimeDatabase() {
        guard let ref = ref else {
            return
        }
        
        let databaseQuery: DatabaseQuery = ref.child(harmonicStationString).queryOrdered(byChild: "t").queryStarting(atValue: DateTimeManagerModel().queryNow).queryEnding(atValue: DateTimeManagerModel().queryHour)
        
//        let databaseQuery: DatabaseQuery = ref.queryOrdered(byChild: "t").queryEqual(toValue:DateTimeManagerModel().queryNow)

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
                    self.tides.append(tide)
                    print(self.tides)
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func stopListening() {
        ref?.removeAllObservers()
    }
}
