//
//  CoreDataMock.swift
//  WeatherAppTestTests
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
@testable import WeatherAppTest

enum CoreDataMockError: Error {
    case error
}

class CoreDataManagerMock: CoreDataManagerHandler {
    let result: Result<WSDateList>
    init(_ result: Result<WSDateList>) {
        self.result = result
    }
    
    func fetchAll(completionHandler: @escaping (Result<WSDateList>) -> Void) {
        completionHandler(result)
    }
    
    func deleteAll() { }
    
    func insertNewObjects(from vm: WSDateList) { }
}
