//
//  WeatherHomeController.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
protocol WeatherHomeHandler {
    var viewModel: WeatherHomeViewModel { get }
    func launch()
}

class WeatherHomeController: NSObject, WeatherHomeHandler {
    let viewModel = WeatherHomeViewModel()
    
    func launch() {
        viewModel.isLoading.value = true
        WeatherAPI.getWeather() { [weak self] result in
            sleep(3)
            switch result {
            case .success(let weatherList):  self?.viewModel.cellViewModels.value = weatherList.dateList.map {
                WeatherHomeCellViewModel( title: "\($0.key)", cellPressed: {print("toto")})
            }
            case .failure(_): self?.viewModel.cellViewModels.value = []
            }
            self?.viewModel.isLoading.value = false
        }
    }
}
