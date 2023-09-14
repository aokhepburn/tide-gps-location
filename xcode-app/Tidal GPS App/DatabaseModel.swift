//
//  DatabaseModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/12/23.
//

import Foundation

struct TidalData: Codable, Identifiable{
    // Codable is used for decoding and encoding the JSON data we get from our API call. Identifiable is used to help us make a unique identifier for our Comments object so our app can keep track of it.
    let id = UUID()
    let t: String
    let v: String
}

//t = time of prediction, v = Tidal height, h/l tide prediction,
