//
//  HomePage.swift
//  WeatherAppTestUITests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
import XCTest
struct HomePage {
    func clickOnFirstCell() -> DetailPage {
        let firstCell = ScenarioManager.app.tables.cells.firstMatch
        XCTAssert(firstCell.waitForExistence(timeout: ScenarioManager.Constants.timeOut))
        firstCell.tap()
        return Pages.detailPage
    }
    
    func clickOnCell(row: Int) -> DetailPage {
        let firstCell = ScenarioManager.app.tables.cells.element(boundBy: row)
        XCTAssert(firstCell.waitForExistence(timeout: ScenarioManager.Constants.timeOut))
        firstCell.tap()
        return Pages.detailPage
    }
}
