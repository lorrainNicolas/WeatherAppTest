//
//  WSWind.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

struct WSWind: Codable {
    let _10m: Double
    
    enum CodingKeys: String, CodingKey {
        case _10m = "10m"
    }
}
