//
//  WSWeatherDate.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
struct WSWeatherDate: Codable {
    let rain: Double
    let temperature: WSTemperature
    let wind: WSWind
    
    enum CodingKeys: String, CodingKey {
        case rain = "pluie"
        case temperature = "temperature"
        case wind = "vent_moyen"
    }
}

