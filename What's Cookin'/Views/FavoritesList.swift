//
//  FavoritesList.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/8/21.
//

import SwiftUI
import URLImage

struct FavoritesList: View {
  
  @EnvironmentObject var favorites: Favorites

    var body: some View {
      VStack {
        if !favorites.favoriteRecipes.isEmpty {
          List {
            ForEach(favorites.favoriteRecipes, id: \.self) { item in
              let url = URL(string: item.image)!
              HStack {
                URLImage(url: url) { image in
                  image
                      .resizable()
                      .frame(width: 50, height: 50)
//                      .aspectRatio(contentMode: .fit)
                }
              Text(item.title)
              }
            }
          }
        }
        
      }
    }

}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
          .environmentObject(Favorites())
    }
}
