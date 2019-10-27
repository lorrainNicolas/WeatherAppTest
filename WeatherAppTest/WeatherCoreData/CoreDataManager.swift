//
//  CoreDataManager.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

protocol CoreDataManagerHandler {
    func fetchAll(completionHandler: @escaping (Result<WSDateList>) -> Void)
    func deleteAll()
    func insertNewObjects(from vm: WSDateList)
}

class CoreDataManager: CoreDataManagerHandler {
    func fetchAll(completionHandler: @escaping (Result<WSDateList>) -> Void) {
        WeatherInformation.fetchAll(completionHandler: completionHandler)
    }
    
    func deleteAll() {
        WeatherInformation.deleteAll()
    }
    
    func insertNewObjects(from vm: WSDateList) {
        WeatherInformation.insertNewObjects(from: vm)
    }
}
