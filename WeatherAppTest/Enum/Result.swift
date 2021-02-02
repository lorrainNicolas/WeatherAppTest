//
//  Result.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
// delete
enum Result<T> {
    case success(T)
    case failure(Error)
}
