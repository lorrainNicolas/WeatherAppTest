//
//  File.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
extension Double {
    var kelvinToCelsius: Double {
        return Double((10 * (self - 273.15)).rounded()/10)
    }
}
