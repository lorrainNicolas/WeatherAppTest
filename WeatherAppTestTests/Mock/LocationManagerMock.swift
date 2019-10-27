//
//  LocationManagerMock.swift
//  WeatherAppTestTests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
import CoreLocation
@testable import WeatherAppTest

class LocationManagerMock: LocationManagerHandler {
    let result: Result<CLLocation>
    init(_ result: Result<CLLocation>) {
        self.result = result
    }
    
    func getCurentLocation(completionHandler: @escaping (Result<CLLocation>) -> Void) {
        completionHandler(result)
    }
}
