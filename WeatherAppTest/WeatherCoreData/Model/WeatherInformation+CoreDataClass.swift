//
//  WeatherInformation+CoreDataClass.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//
//

import Foundation
import CoreData

@objc(WeatherInformation)
public class WeatherInformation: NSManagedObject {
    
    class func fetchAll(completionHandler: @escaping (Result<WSDateList>) -> Void){
        let context = CoreDataStack.shared.managedContext
        let fetchRequest: NSFetchRequest<WeatherInformation> = WeatherInformation.fetchRequest()
        context.perform {
            do {
                let data = try context.fetch(fetchRequest)
                completionHandler(.success(self.map(data)))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }
    
    class func deleteAll() {
        let context = CoreDataStack.shared.managedContext
        let fetchRequest: NSFetchRequest<WeatherInformation>  = WeatherInformation.fetchRequest()
        context.perform {
            do {
                let data = try context.fetch(fetchRequest)
                data.forEach{ context.delete($0) }
                CoreDataStack.shared.saveContext()
            } catch let error {
               Log.error("error during deleting: \(error)")
            }
            
        }
    }
    
    class func insertNewObjects(from vm: WSDateList) {
        let context = CoreDataStack.shared.managedContext
        context.perform {
            vm.dateList.forEach {
                let newObject =  WeatherInformation(context: context)
                newObject.date = $0.key
                newObject.rain = $0.value.rain as NSNumber
                newObject.temperature = $0.value.temperature._2m  as NSNumber
            }
            CoreDataStack.shared.saveContext()
        }
    }
}

private extension WeatherInformation {
    class func map(_ data: [WeatherInformation]) -> WSDateList {
        var dateList = [Date: WSWeatherDate]()
        data.forEach {
            let temperature = WSTemperature(_2m: $0.temperature.doubleValue)
            let weatherDate = WSWeatherDate(rain: $0.rain.doubleValue, temperature: temperature)
            dateList[$0.date] = weatherDate
        }
        
        return WSDateList(dateList: dateList)
    }
}
