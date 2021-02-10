//
//  ContentView.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI


struct ContentView: View {
  @State private var selection: Tab = .search

  enum Tab {
      case search
      case favorites
  }
    var body: some View {
      
      TabView(selection: $selection) {
          Search()
              .tabItem {
                  Label("Explore", systemImage: "magnifyingglass")
              }
              .tag(Tab.search)

          FavoritesList()
              .tabItem {
                  Label("Favorites", systemImage: "heart")
              }
              .tag(Tab.favorites)
      }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
