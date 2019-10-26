//
//  WeatherHomeViewModel.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

class WeatherHomeViewModel {
    let isLoading = Observable<Bool>(false)
    let informationHeader = Observable<String>("Welcome")
    let cellViewModels = Observable<[WeatherHomeCellViewModel]>([])
}

extension WeatherHomeViewModel {
    var numberOfRow: Int {
        return cellViewModels.value.count
    }
}
