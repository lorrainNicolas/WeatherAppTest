//
//  WeatherHomeControllerTest.swift
//  WeatherAppTestTests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import XCTest
import CoreLocation
@testable import WeatherAppTest

class WeatherHomeControllerTest: XCTestCase {
    func testFetchWithNoLocation() {
        //Given
        let locationManager = LocationManagerMock(.failure(LocationManagerError.permissionDenied))
        let apiWeather = WeatherAPIMock(.failure(APIError.invalidURL))
        let coreDataManager = CoreDataManagerMock(.success(WSDateList(dateList: [Date : WSWeatherDate]())))
        let controller = WeatherHomeController(locationManager: locationManager, weatherApi: apiWeather, coreDataManager: coreDataManager)
        
        //When
        controller.launch()
        
        //Them
        XCTAssert( controller.viewModel.informationHeader.value == "error: cannot get your position")
        XCTAssert( controller.viewModel.cellViewModels.value.count == 0)
        XCTAssert( controller.viewModel.numberOfRow == 0)
        XCTAssert( controller.viewModel.isLoading.value == false)
    }
    
    func testFetchWitLocationAndWithEmptyDataFromWS() {
        //Given
        let locationManager = LocationManagerMock(.success(CLLocation()))
        let result = WSDateList(dateList: [Date : WSWeatherDate]())
        let apiWeather = WeatherAPIMock(.success(result))
        let coreDataManager = CoreDataManagerMock(.success(WSDateList(dateList: [Date : WSWeatherDate]())))
        let controller = WeatherHomeController(locationManager: locationManager, weatherApi: apiWeather, coreDataManager: coreDataManager)
        
        //When
        controller.launch()
        
        //Them
        XCTAssert( controller.viewModel.informationHeader.value == "Welcome : from WS")
        XCTAssert( controller.viewModel.cellViewModels.value.count == 0)
        XCTAssert( controller.viewModel.numberOfRow == 0)
        XCTAssert( controller.viewModel.isLoading.value == false)
    }
    
    func testFetchWitLocationAndWithDataFromWS() {
        //Given
        let locationManager = LocationManagerMock(.success(CLLocation()))
        var dico = [Date : WSWeatherDate]()
        dico[Date()] = WSWeatherDate(rain: 1, temperature: WSTemperature(_2m: 1), wind: WSWind(_10m: 12))
        
        let apiWeather = WeatherAPIMock(.success(WSDateList(dateList: dico)))
        let coreDataManager = CoreDataManagerMock(.success(WSDateList(dateList: [Date : WSWeatherDate]())))
        
        let controller = WeatherHomeController(locationManager: locationManager, weatherApi: apiWeather, coreDataManager: coreDataManager)
        
        //When
        controller.launch()
        
        //Them
        XCTAssert( controller.viewModel.informationHeader.value == "Welcome : from WS")
        XCTAssert( controller.viewModel.cellViewModels.value.count == 1)
        XCTAssert( controller.viewModel.numberOfRow == 1)
        XCTAssert( controller.viewModel.isLoading.value == false)
    }
    
    func testFetchWitLocationAndFailedFromWSAndHasCoreData() {
        //Given
        let locationManager = LocationManagerMock(.success(CLLocation()))
        let apiWeather = WeatherAPIMock(.failure(APIError.invalidURL))
        var dico = [Date : WSWeatherDate]()
        dico[Date()] = WSWeatherDate(rain: 1, temperature: WSTemperature(_2m: 1), wind: WSWind(_10m: 12))
        let coreDataManager = CoreDataManagerMock(.success(WSDateList(dateList: dico)))
        
        let controller = WeatherHomeController(locationManager: locationManager, weatherApi: apiWeather, coreDataManager: coreDataManager)
           
        //When
        controller.launch()
           
        //Them
        XCTAssert( controller.viewModel.informationHeader.value == "Welcome : from core Data")
        XCTAssert( controller.viewModel.cellViewModels.value.count == 1)
        XCTAssert( controller.viewModel.numberOfRow == 1)
        XCTAssert( controller.viewModel.isLoading.value == false)
    }
    
    func testFetchWitLocationAndFailedFromWSAndCoreDataFailed() {
        //Given
        let locationManager = LocationManagerMock(.success(CLLocation()))
        let apiWeather = WeatherAPIMock(.failure(APIError.invalidURL))
        let coreDataManager = CoreDataManagerMock(.failure(CoreDataMockError.error))
        
        let controller = WeatherHomeController(locationManager: locationManager, weatherApi: apiWeather, coreDataManager: coreDataManager)
           
        //When
        controller.launch()
           
        //Them
        XCTAssert( controller.viewModel.informationHeader.value == "cannot get your data")
        XCTAssert( controller.viewModel.cellViewModels.value.count == 0)
        XCTAssert( controller.viewModel.numberOfRow == 0)
        XCTAssert( controller.viewModel.isLoading.value == false)
    }
}

