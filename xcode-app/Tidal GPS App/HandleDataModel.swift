//
//  HandleDataModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/19/23.
//

import Foundation
import CoreLocation
import FirebaseDatabase

func ifElseStatementsForGPSHeights (coordinate: CLLocationCoordinate2D?) {
    let tidalHeightsQueryModel = TidalHeightsQueryModel()
    
    if Float(coordinate?.latitude ?? 0) < 40.66912 && Float(coordinate?.latitude ?? 0) > 40.587279 && Float(coordinate?.longitude ?? 0) > -74.10612 && Float(coordinate?.longitude ?? 0) < -73.98512 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTUSCGStation(8519050)LAT4060194LON-7405167"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.6526 && Float(coordinate?.latitude ?? 0) > 40.5949 && Float(coordinate?.longitude ?? 0) > -74.2035 && Float(coordinate?.longitude ?? 0) < -73.994623 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTBergenPointWestReach(8519483)LAT40634167LON-7413556"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.76357 && Float(coordinate?.latitude ?? 0) > 40.66912 && Float(coordinate?.longitude ?? 0) > -74.08729 && Float(coordinate?.longitude ?? 0) < -74.00076 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTTheBattery(8518750)LAT407LON-740025"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.715242 && Float(coordinate?.latitude ?? 0) > 40.698782 && Float(coordinate?.longitude ?? 0) > -74.00076 && Float(coordinate?.longitude ?? 0) < -73.97496 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTBrooklynBridge(8517847)LAT4070056LON-73985278"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.724971 && Float(coordinate?.latitude ?? 0) > 40.715242 && Float(coordinate?.longitude ?? 0) > -73.97496 && Float(coordinate?.longitude ?? 0) < -73.95743923 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTWilliamsburgBridge(8518699)LAT4070194LON-7396694"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.76799432232893 && Float(coordinate?.latitude ?? 0) > 40.724971 && Float(coordinate?.longitude ?? 0) > -73.96356351064199 && Float(coordinate?.longitude ?? 0) < -73.93889 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTQueensboroBridge(8518687)LAT40751389LON-7395138"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.78572 && Float(coordinate?.latitude ?? 0) > 40.767994322 && Float(coordinate?.longitude ?? 0) > -73.95206 && Float(coordinate?.longitude ?? 0) < -73.91717 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTHornsHook(8518668)LAT407683LON-7393472"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.80288 && Float(coordinate?.latitude ?? 0) > 40.78572 && Float(coordinate?.longitude ?? 0) > -73.94521 && Float(coordinate?.longitude ?? 0) < -73.91112 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTRandallsIsland(8518643)LAT408LON-7391861"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.827655 && Float(coordinate?.latitude ?? 0) > 40.78572 && Float(coordinate?.longitude ?? 0) > -73.91112 && Float(coordinate?.longitude ?? 0) < -73.80903 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTPortMorris(8518639)LAT40800278LON-739011"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    } else if Float(coordinate?.latitude ?? 0) < 40.78572 && Float(coordinate?.latitude ?? 0) > 40.7457166 && Float(coordinate?.longitude ?? 0) > -73.8739028 && Float(coordinate?.longitude ?? 0) < -73.831424 {
        tidalHeightsQueryModel.harmonicStationString = "HEIGHTWorldsFairMarina(8517251)LAT4075194LON-7385"
        tidalHeightsQueryModel.retrieveTidesForDisplay()
    }
}
