//
//  WebServicesManager.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

public typealias JSONObject = [String: Any]

enum APIError: Error {
    case invalidURL
    case invalidParameter
    case invalidData
    case invalidJSON
}

public class WebServicesManager {
    static func request(url: String, query: [String: String] = [:], completionHandler: @escaping (Result<JSONObject>) -> Void) {

        var queryString = ""
        query.forEach {
            queryString.isEmpty ? queryString.append("?\($0.key)=\($0.value)") : queryString.append("&\($0.key)=\($0.value)")
        }

        guard let components = URLComponents(string: url + queryString),
            let url = components.url else {
            completionHandler(.failure(APIError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let json = (try? JSONSerialization.jsonObject(with: data)) as? JSONObject {
                completionHandler(.success(json))
            } else {
                completionHandler(.failure(APIError.invalidData))
            }
        }
        
        task.resume()
    }
}
