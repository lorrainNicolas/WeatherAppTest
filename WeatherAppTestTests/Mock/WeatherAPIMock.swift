//
//  WeatherAPIMock.swift
//  WeatherAppTestTests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
@testable import WeatherAppTest
class WeatherAPIMock: WeatherAPIHandler {
    let result: Result<WSDateList>
    init(_ result: Result<WSDateList>) {
        self.result = result
    }
    
    func getWeather(longitude: Double, latitude: Double, completionHandler: @escaping (Result<WSDateList>) -> Void) {
        completionHandler(result)
    }
}
