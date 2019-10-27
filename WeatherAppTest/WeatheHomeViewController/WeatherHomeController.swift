//
//  WeatherHomeController.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
import CoreData

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
        self.viewModel.isLoading.value = true
        getLocation()
    }
}

// MARK: Helpers: Get Method
private extension WeatherHomeController {
    func getLocation() {
        locationManage.getCurentLocation() { [weak self] result in
            self?.viewModel.informationHeader.value = "getting your position"
            switch result {
            case .success(let location):
                self?.getWeather(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
            case .failure(_):
                self?.viewModel.informationHeader.value = "error: cannot get your position"
                self?.viewModel.isLoading.value = false
            }
        }
    }
    
    func getWeather(longitude: Double, latitude: Double) {
        
        self.viewModel.informationHeader.value = "fetch Data"
        sleep(3)
        WeatherAPI.getWeather(longitude:longitude, latitude: latitude) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherList):
                self.viewModel.cellViewModels.value = self.generateWeatherHomeCellViewModels(from: weatherList)
                WeatherInformation.deleteAll()
                WeatherInformation.insertNewObjects(from: weatherList)
                self.viewModel.informationHeader.value = "Welcome from WS \(weatherList.dateList.count) element"
                self.viewModel.isLoading.value = false
            case .failure(_):
                self.fetchWeather()
            }
        }
    }
    
    func fetchWeather() {
        WeatherInformation.fetchAll() {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherList):
                self.viewModel.cellViewModels.value = self.generateWeatherHomeCellViewModels(from: weatherList)
                self.viewModel.informationHeader.value = "Welcome from core Data \(weatherList.dateList.count) element"
            case .failure(_):
                self.viewModel.cellViewModels.value = []
                self.viewModel.informationHeader.value = "cannot get your data"
            }
            self.viewModel.isLoading.value = false
        }
    }
    
}

// MARK: Helpers
private extension WeatherHomeController {
    func generateWeatherHomeCellViewModels(from list: WSDateList) -> [WeatherHomeCellViewModel] {
        let viewModelList = list.dateList.map {
            WeatherHomeCellViewModel( date: ($0.key), cellPressed: { [weak self] in
                self?.delegate?.launchDetailVC()
            })
        }.sorted {
            $0.date.compare($1.date) == .orderedAscending
        }
        return viewModelList
    }
}
