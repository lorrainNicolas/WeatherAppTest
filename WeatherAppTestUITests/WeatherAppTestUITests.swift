//
//  WeatherAppTestUITests.swift
//  WeatherAppTestUITests
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import XCTest

class WeatherAppTestUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let _ = Pages.homePage
                    .clickOnFirstCell()
                    .clickOnBack()
                    .clickOnCell(row: 1)
                    .clickOnBack()
                    .clickOnCell(row: 2)
                    .clickOnBack()
                    .clickOnCell(row: 3)
                    .clickOnBack()
                    .clickOnCell(row: 4)
        
    }
}
