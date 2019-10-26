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
    
    // TODO: IMPROVE THIS
    func launch() {
        viewModel.isLoading.value = true
        locationManage.getCurentLocation(completionHandler: { [weak self] result in
            self?.viewModel.informationHeader.value = "getting your position"
            
            switch result {
            case .success(let location):
                
                self?.viewModel.informationHeader.value = "fetch Data"
                WeatherAPI.getWeather(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude) { [weak self] result in
                    sleep(3)
                    switch result {
                    case .success(let weatherList):
                        self?.viewModel.cellViewModels.value = weatherList.dateList.map {
                        WeatherHomeCellViewModel( title: "\($0.key)", cellPressed: { [weak self] in
                            self?.delegate?.launchDetailVC()
                        })
                        }
                        self?.viewModel.informationHeader.value = "Welcome"
                    case .failure(_):
                        self?.viewModel.cellViewModels.value = []
                        self?.viewModel.informationHeader.value = "error: cannot get your data"
                        
                    }
                    self?.viewModel.isLoading.value = false
                }
                
            case .failure(_):
                self?.viewModel.informationHeader.value = "error: cannot get your position"
                self?.viewModel.isLoading.value = false
            }
        })
    }
}
