//
//  Tidal_GPS_AppUITests.swift
//  Tidal GPS AppUITests
//
//  Created by Alice Hepburn on 9/5/23.
//

import XCTest
import CoreLocation

final class Tidal_GPS_AppUITests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
//    func testLocation() throws {
//      XCUIDevice.shared.location = XCUILocation(location: CLLocation(latitude: 37.334886, longitude: -122.008988))
//       Launch your app and run the test.
//    }
}
