//
//  WeatherAPI.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
class WeatherAPI {
    
    static func getWeather(completionHandler: @escaping (Result<WSDateList>) -> Void) {
        let query: [String: String] = [Constants.llKey: Constants.defaultLocalisation,
                                       Constants.authKey: Constants.apiKey]
        
        WebServicesManager.request(url: Constants.url, query: query) { result in
            switch result {
            case .success(let json):
                var weatherDateList = [Date: WSWeatherDate]()
                json.forEach {
                    guard let date = DateFormatter.weatherJsonFormatter.date(from: $0.key),
                        let data = try? JSONSerialization.data(withJSONObject: $0.value, options: .prettyPrinted),
                        let value = try? JSONDecoder().decode(WSWeatherDate.self, from: data) else { return }
                    weatherDateList[date] = value
                    
                }
                completionHandler(.success(WSDateList(dateList: weatherDateList)))
                
            case .failure(let error):
                Log.error(error)
                completionHandler(.failure(error))
            }
        }
    }
    
    
}

private extension WeatherAPI {
    enum Constants {
        static let defaultLocalisation = "48.85341,2.3488"
        static let llKey = "_ll"
        static let authKey = "_auth"
        static let url = "http://www.infoclimat.fr/public-api/gfs/json"
        static let apiKey = "VkwCFVQqUXNUeQA3AHZReFE5U2ZdKwAnBHhSMQtuAH0IY1AxAWFXMV4wUy4DLAM1WXRTMF5lBDQEbwR8CnhWN1Y8Am5UP1E2VDsAZQAvUXpRf1MyXX0AJwRuUjULeABqCGtQKgFjVzJeMlMvAzQDP1l1UyxeYAQ5BGAEYQpnVjJWNwJiVDVRM1QkAH0ANVExUTBTMF03AGoEMlIxC2EAZghsUD0BalcxXi9TNwM1AzNZY1M3XmUENQRlBHwKeFZMVkYCe1R3UXFUbgAkAC1RMFE8U2c%3D&_c=06b168305bbd63896785ac54af7f501a"
    }
}
