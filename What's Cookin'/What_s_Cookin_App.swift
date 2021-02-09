//
//  What_s_Cookin_App.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI

@main
struct What_s_Cookin_App: App {
  @StateObject private var favorites = Favorites()
  
  
    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(favorites)
        }
    }
}
