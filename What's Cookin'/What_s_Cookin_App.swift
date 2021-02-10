//
//  What_s_Cookin_App.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI

@main
struct What_s_Cookin_App: App {
  let persistenceController = PersistenceController.shared
  @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
          ContentView()
              .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
