//
//  WeatherCreDataManager.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    
    init() {
        self.modelName = "WeatherModel"
    }
    
    static var shared = CoreDataStack()
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    func saveContext () {
      guard managedContext.hasChanges else { return }
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Unresolved error \(error), \(error.userInfo)")
      }
    }
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
              if let error = error as NSError? {
                  Log.error("Unresolved error \(error), \(error.userInfo)")
              }
          }
          return container
    }()
}
