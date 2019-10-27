//
//  WeatherHomeCellViewModel.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
struct  WeatherHomeCellViewModel {
    let date: Date
    let tempeature: Double
    let cellPressed: (() -> Void)?
}

extension WeatherHomeCellViewModel {
    var dateString: String {
        return DateFormatter.dayFormatter.string(from: date)
    }
    
    var tempeatureString: String {
        return "\(tempeature)°"
    }
}
