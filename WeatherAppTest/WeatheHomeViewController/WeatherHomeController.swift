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
    func launchDetailVC(with viewModels: [DetailCellViewModel])
}

class WeatherHomeController: NSObject, WeatherHomeHandler {
    let viewModel = WeatherHomeViewModel()
    weak var delegate: WeatherHomeCoordinatorDelegate?
    
    private let locationManager: LocationManagerHandler
    private let weatherApi: WeatherAPIHandler
    private let coreDataManager: CoreDataManagerHandler
    
    init(locationManager: LocationManagerHandler = LocationManager(),
         weatherApi: WeatherAPIHandler = WeatherAPI(),
         coreDataManager: CoreDataManagerHandler = CoreDataManager()) {
        self.locationManager = locationManager
        self.weatherApi = weatherApi
        self.coreDataManager = coreDataManager
        super.init()
    }
    
    func launch() {
        self.viewModel.isLoading.value = true
        getLocation()
    }
}

// MARK: Helpers: Get Method
private extension WeatherHomeController {
    func getLocation() {
        locationManager.getCurentLocation() { [weak self] result in
            self?.viewModel.informationHeader.value = "getting your position"
            switch result {
            case .success(let location):
                self?.getWeatherFromWS(longitude: location.coordinate.longitude, latitude: location.coordinate.latitude)
            case .failure(_):
                self?.viewModel.informationHeader.value = "error: cannot get your position"
                self?.viewModel.isLoading.value = false
            }
        }
    }
    
    func getWeatherFromWS(longitude: Double, latitude: Double) {
        self.viewModel.informationHeader.value = "fetch Data"
        sleep(3)
        weatherApi.getWeather(longitude:longitude, latitude: latitude) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherList):
                self.viewModel.cellViewModels.value = self.generateDailyCellViewModels(from: weatherList)
                self.persistData(weatherList: weatherList)
                self.viewModel.informationHeader.value = "Welcome : from WS"
                self.viewModel.isLoading.value = false
            case .failure(_):
                self.fetchWeatherFromCoreData()
            }
        }
    }
    
    func fetchWeatherFromCoreData() {
        coreDataManager.fetchAll() {  [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weatherList):
                self.viewModel.cellViewModels.value = self.generateDailyCellViewModels(from: weatherList)
                self.viewModel.informationHeader.value = "Welcome : from core Data"
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
    func generateDailyCellViewModels(from list: WSDateList) -> [DailyCellViewModel] {
        var groupDateListByDay = [Date: [WSWeatherDate]]()
        list.dateList.forEach {
            groupDateListByDay[$0.key.currentDay(), default:[WSWeatherDate]()].append($0.value)
        }

        return groupDateListByDay.compactMap {
            let currentDate = $0.key
            guard let temperature = getFirstTemperature(of: currentDate, from: list) else { return nil }
            return DailyCellViewModel(date: currentDate,
                                      tempeature: temperature.kelvinToCelsius,
                                      cellPressed: cellPressed(with: currentDate, from: list))
        }.sorted {$0.date.compare($1.date) == .orderedAscending}
    }
    
    func generateDetailCellViewModels(with date: Date, from list: WSDateList) -> [DetailCellViewModel] {
        return list.dateList.filter { Calendar.current.isDate($0.key, inSameDayAs: date) }
            .map { DetailCellViewModel(date: $0.key,
                                       tempeature: $0.value.temperature._2m.kelvinToCelsius,
                                       rain: $0.value.rain,
                                       wind: $0.value.wind._10m) }
            .sorted { $0.date.compare($1.date) == .orderedAscending }
    }
    
    func cellPressed(with date: Date, from list: WSDateList) ->  (() -> Void) {
        return {
            self.delegate?.launchDetailVC(with:self.generateDetailCellViewModels(with: date, from: list))
        }
    }
    
    func getFirstTemperature(of day: Date, from list: WSDateList) -> Double? {
        return list.dateList.sorted {  $0.key.compare($1.key) == .orderedAscending }
            .first(where: { Calendar.current.isDate($0.key, inSameDayAs: day) })?.value.temperature._2m
    }
    
    func persistData(weatherList: WSDateList) {
        coreDataManager.deleteAll()
        coreDataManager.insertNewObjects(from: weatherList)
    }

}
