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
    
    class func fetchAll(completionHandler: @escaping (Result<[WeatherInformation]>) -> Void){
        let context = CoreDataStack.shared.managedContext
        let fetchRequest: NSFetchRequest<WeatherInformation>  = WeatherInformation.fetchRequest()
        context.perform {
            do {
                let data = try context.fetch(fetchRequest)
                completionHandler(.success(data))
            } catch let error {
                completionHandler(.failure(error))            }
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
    
    class func insertNewObject(from vm: WSDateList) {
        let context = CoreDataStack.shared.managedContext
        context.perform {
            vm.dateList.forEach {
                let newObject =  WeatherInformation(context: context)
                newObject.date = $0.key
            }
            CoreDataStack.shared.saveContext()
        }
    }
}

