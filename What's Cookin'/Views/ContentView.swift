//
//  ContentView.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI


struct ContentView: View {
  @State private var selection: Tab = .search
  @State var showSplash = true
  enum Tab {
      case search
      case favorites
  }
    var body: some View {
      ZStack {
      SplashScreen()
        .opacity(showSplash ? 1 : 0)
        .onAppear {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation() {
              self.showSplash = false
            }
          }
      }
    if showSplash == false{
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
      


    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
