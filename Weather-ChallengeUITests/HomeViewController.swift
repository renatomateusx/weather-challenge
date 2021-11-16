//
//  Weather_ChallengeUITests.swift
//  Weather-ChallengeUITests
//
//  Created by Renato Mateus on 15/11/21.
//

import XCTest

class HomeViewController: XCTestCase {
    
    func testTextField() {
        let app = XCUIApplication()
        app.launch()
        let tf = app.textFields["tf"]
        tf.tap()
        tf.typeText("Salvador")
        let button = app.buttons["button"]
        button.tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
