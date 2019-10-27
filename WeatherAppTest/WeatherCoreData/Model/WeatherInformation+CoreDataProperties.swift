//
//  WeatherInformation+CoreDataProperties.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherInformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherInformation> {
        return NSFetchRequest<WeatherInformation>(entityName: "WeatherInformation")
    }

    @NSManaged public var date: Date
    @NSManaged public var rain: NSNumber
    @NSManaged public var temperature: NSNumber
}
