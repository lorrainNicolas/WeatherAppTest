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
        WeatherAPI.getWeather(longitude:longitude, latitude: latitude) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherList):
                self.viewModel.cellViewModels.value = weatherList.dateList.map { self.createViewModel(date: $0.key) }
                WeatherInformation.deleteAll()
                WeatherInformation.insertNewObject(from: weatherList)
                self.viewModel.informationHeader.value = "Welcome from WS \(weatherList.dateList.count) element"
            case .failure(_):
                self.fetchWeather()
            }
        }
    }
    
    func fetchWeather() {
        WeatherInformation.fetchAll() {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherInformationList):
                self.viewModel.cellViewModels.value = weatherInformationList.map{self.createViewModel(date: $0.date!) }
                 self.viewModel.informationHeader.value = "Welcome from core Data \(weatherInformationList.count) element"
            case .failure(_):
                self.viewModel.cellViewModels.value = []
                self.viewModel.informationHeader.value = "cannot get your data"
            }
        }
    }
    
}

// MARK: Helpers
private extension WeatherHomeController {
    func createViewModel(date: Date) -> WeatherHomeCellViewModel {
        return WeatherHomeCellViewModel( title: "\(date)", cellPressed: { [weak self] in
            self?.delegate?.launchDetailVC()
        })
    }
}
