//
//  WSTemperature.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

struct WSTemperature: Codable {
    let _2m: Double
    
    enum CodingKeys: String, CodingKey {
        case _2m = "2m"
    }
}
