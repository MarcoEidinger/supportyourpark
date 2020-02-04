//
//  supportyourparkUITests.swift
//  supportyourparkUITests
//
//  Created by Eidinger, Marco on 1/25/20.
//  Copyright © 2020 Eidinger, Marco. All rights reserved.
//

import XCTest

class supportyourparkUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigateFromHomeToParkDetails() {
        let app = XCUIApplication()
        app.launch()

        app.tables/*@START_MENU_TOKEN@*/.scrollViews/*[[".cells.scrollViews",".scrollViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.otherElements.buttons["Arches"].tap()
        app.navigationBars.firstMatch.buttons["Featured"].tap()

        let tablesQuery = XCUIApplication().tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Others"]/*[[".cells.staticTexts[\"Others\"]",".staticTexts[\"Others\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["See All"]/*[[".cells.buttons[\"See All\"]",".buttons[\"See All\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testNavigateFromHomeToMap() {
        let app = XCUIApplication()
        app.launch()

        addUIInterruptionMonitor(withDescription: "Allow “supportyourpark” to access your location?") {
          (alert) -> Bool in
            let okButton = alert.buttons["Allow While Using App"]
            if okButton.exists {
              okButton.tap()
            }
          return true
        }

        XCUIApplication().tabBars.buttons["Map"].tap()
        //XCTAssertTrue(app.alerts["Warning"].waitForExistence(timeout: 1))
        //XCUIApplication().alerts["Allow “supportyourpark” to access your location?"].scrollViews.otherElements.buttons["Allow While Using App"].tap()
        XCUIApplication().tabBars.buttons["Parks"].tap()

    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
