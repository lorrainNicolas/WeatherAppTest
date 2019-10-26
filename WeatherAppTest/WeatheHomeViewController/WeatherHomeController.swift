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

protocol WeatherHomeCoordinatorDelegate: class {
    func launchDetailVC()
}

class WeatherHomeController: NSObject, WeatherHomeHandler {
    let viewModel = WeatherHomeViewModel()
    let locationManage = LocationManager()
    weak var delegate: WeatherHomeCoordinatorDelegate?
    
    func launch() {
        viewModel.isLoading.value = true
        locationManage.getCurentLocation(completionHandler: { result in
            switch result {
            case .success(let location): break;
            case .failure(_): break;
            }
        })
        
        WeatherAPI.getWeather() { [weak self] result in
            sleep(3)
            switch result {
            case .success(let weatherList):  self?.viewModel.cellViewModels.value = weatherList.dateList.map {
                WeatherHomeCellViewModel( title: "\($0.key)", cellPressed: { [weak self] in
                    self?.delegate?.launchDetailVC()
                })
            }
            case .failure(_): self?.viewModel.cellViewModels.value = []
            }
            self?.viewModel.isLoading.value = false
        }
    }
}
