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
    let cellPressed: (() -> Void)?
}

extension WeatherHomeCellViewModel {
    var title: String {
        return "\(date)"
    }
}
