//
//  DetailPage.swift
//  WeatherAppTestUITests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
struct DetailPage {
    func clickOnBack() -> HomePage {
        sleep(3)
        ScenarioManager.app.navigationBars.buttons.element(boundBy: 0).tap()
        return Pages.homePage
    }
}
