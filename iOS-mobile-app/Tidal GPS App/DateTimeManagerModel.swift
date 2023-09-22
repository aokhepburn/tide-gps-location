//
//  DateTimeManagerModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/7/23.
//

import Foundation

class DateTimeManagerModel: NSObject, ObservableObject{
    @Published var dateObject: Date?
    @Published var displayNow: String?
    @Published var queryNow: String?
    @Published var halfHourIntervalObject: Date?
    @Published var queryHour: String?
    @Published var queryForOneEntry: String?
    
    //formatting for viewing in app
    private let displayDateFormatter = DateFormatter()
    
    //formatting to match the NOAA api to match the value and retrieve correct tide
    private let queryDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            return formatter
        }()
    

    override init() {
        self.dateObject = Date()
        self.halfHourIntervalObject = Date(timeIntervalSinceNow:1800)
        
        super.init()
        //formatting string for api call
        self.queryNow = queryDateFormatter.string(from: self.dateObject!)
        
        self.queryHour = queryDateFormatter.string(from: self.halfHourIntervalObject!)
        
        //formatting string for display
        displayDateFormatter.timeStyle = .short
        displayDateFormatter.dateStyle = .long
        self.displayNow = displayDateFormatter.string(from: self.dateObject!)
       }
}
