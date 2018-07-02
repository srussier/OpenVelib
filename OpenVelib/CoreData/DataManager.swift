//
//  DataManager.swift
//  OpenVelib
//
//  Created by Salomé Russier on 30/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import CoreData

class DataManager {

    public static let shared = DataManager()
    
    public var objectContext: NSManagedObjectContext? = nil
    
    private init() {
        if let modelURL = Bundle.main.url(forResource: "velib", withExtension: "momd") {
            if let model = NSManagedObjectModel(contentsOf: modelURL) {
                if let storageURL = FileManager.documentURL(childPath: "MyDatabase.db") {
                    let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                    _ = try? storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storageURL, options: nil)
                    
                    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                    context.persistentStoreCoordinator = storeCoordinator
                    self.objectContext = context
                }
            }
        }
    }
    
    
    
    
}
