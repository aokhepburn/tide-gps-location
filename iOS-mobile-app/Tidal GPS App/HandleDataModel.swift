//
//  HandleDataModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/19/23.
//

import Foundation
import CoreLocation
import FirebaseDatabase

//💥💥💥💥💥💥 REMEMBER TO REMOVE THIS FILE FROM THE GITIGNORE WHEN IT HAS ACTUAL CODE!

struct FloodSlackEbb: Codable, Identifiable{
    let id = UUID()
    let flood: Bool
    let ebb: Bool
    let slack: Bool
}



//if tidesfordisplay[0].prediction < tidesfordiplay[1].prediction && tidesfordisplay[1].prediction < tides[2].prediction && etc for return set of time (an hour?)
//else if the same as a above but with greater than BECAUSE, maybe not a boolean return then:
//else SLACK
//setting the "isFlooding" boolean instead to a string that is printed?
//OR letting each isSlack isFlood isEbb be their own booleans that can be cooberated by speed data (and that is just greater or less than zero! - maybe use that as a last minute work around for demo? - )

//still need to get basic high tide times printed, and then tie that in with the elridge guides, were good were good we got time.... just get the data from the same stations as the height stations and tie in same geolocation logic
