//
//  ContentView.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI


struct ContentView: View {
  
    var body: some View {
      TabView {
                  Search()
                      .tabItem {
                          Image(systemName: "magnifyingglass")
                          Text("Explore")
                      }
              }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
