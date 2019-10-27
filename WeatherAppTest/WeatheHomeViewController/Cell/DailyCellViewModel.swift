//
//  DailyCellViewModel.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
struct  DailyCellViewModel {
    let date: Date
    let tempeature: Double
    let cellPressed: (() -> Void)?
}

extension DailyCellViewModel {
    var dateString: String {
        return DateFormatter.dayFormatter.string(from: date)
    }
    
    var tempeatureString: String {
        return "\(tempeature)°"
    }
}
