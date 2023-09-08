//
//  DateTimeManagerModel.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/7/23.
//

import Foundation

class DateTimeManagerModel: NSObject, ObservableObject{
//    var date: Date?
//    var time: Date?
    @Published var dateObject: Date?
    @Published var now: String?
    
    private let dateFormatter = DateFormatter()

    override init() {
        super.init()
        self.dateObject = Date()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        self.now = dateFormatter.string(from: self.dateObject!)
        
       }
    
//    func dateString(){
//        var date = String(formatted(date: dateObject.DateStyle.short, time: dateObject.TimeStyle.short))
//    }

    
     // You can specify the time format you want here

    
    
//    init(
//        calendar: Calendar? = nil,
//        timeZone: TimeZone? = nil,
//        era: Int? = nil,
//        year: Int? = nil,
//        month: Int? = nil,
//        day: Int? = nil,
//        hour: Int? = nil,
//        minute: Int? = nil,
//        second: Int? = nil,
//        nanosecond: Int? = nil,
//        weekday: Int? = nil,
//        weekdayOrdinal: Int? = nil,
//        quarter: Int? = nil,
//        weekOfMonth: Int? = nil,
//        weekOfYear: Int? = nil,
//        yearForWeekOfYear: Int? = nil
//    ){
//        self.date = Date()
//    }
    
//    convenience init?() {
        // what happens now
//    }
}
