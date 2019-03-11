//
//  CoreDataStack.swift
//  Tiny Timer
//
//  Created by Patrick Kalkman on 10/03/2019.
//  Copyright © 2019 SimpleTechture. All rights reserved.
//

import Foundation
import CoreData

func createMainContext() -> NSManagedObjectContext {
   
   let modelURL = Bundle.main.url(forResource: "TinyTimerModel", withExtension: "momd")
   
   guard let modelUnwrappedUrl = modelURL else {
      fatalError("Could not get the url to the TinyTimer model")
   }
   
   guard let model = NSManagedObjectModel(contentsOf: modelUnwrappedUrl) else {
      fatalError("Could not construct managed object model from TinyTimer model")
   }
   
   let psc : NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
   
   let storeURL = try! FileManager
      .default
      .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      .appendingPathComponent("TinyTimer.sqlite")
   
   try! psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
   
   let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
   context.persistentStoreCoordinator = psc
   
   return context
}


