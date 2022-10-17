//
//  CoreDataManager.swift
//  Constructor
//
//  Created by Denys on 17.06.2022.
//

import Foundation
import CoreData

//abstract class for saving to core data
class CoreDataManager {
    
    static let instance = CoreDataManager() //Singleton
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        context = container.viewContext
    }
    
    // save to coredata
    func save() {
        do {
            try context.save()
            print("Save Sucess!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
    
}
