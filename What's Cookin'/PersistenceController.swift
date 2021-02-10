//
//  PersistenceController.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/10/21.
//

import Foundation
import SwiftUI
import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {

        container = NSPersistentContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
  
  func saveContext() {
      let context = container.viewContext

      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Show some error here
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
}
