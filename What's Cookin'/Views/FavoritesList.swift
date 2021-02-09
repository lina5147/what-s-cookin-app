//
//  FavoritesList.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/8/21.
//

import SwiftUI

struct FavoritesList: View {
  
  @EnvironmentObject var favorites: Favorites

    var body: some View {
      VStack {
      Text("\(favorites.timeCount)")
      Button(action: add) {
          Text("add")
      }
      }
    }
  
  func add() {
    favorites.timeCount += 1
  }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
          .environmentObject(Favorites())
    }
}
