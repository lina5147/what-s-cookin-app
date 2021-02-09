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
      NavigationView{
        ZStack {
          Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
          ScrollView{
            VStack {
            if !favorites.favoriteRecipes.isEmpty {
//              List {
                ForEach(favorites.favoriteRecipes, id: \.self) { item in
                  let url = URL(string: item.image)!
                  HStack {
                    URLImage(url: url) { image in
                      image
                          .resizable()
                          .cornerRadius(8)
                        .frame(width: 70, height: 60)
                        .padding(.horizontal, 8.0)
//                          .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    Text(item.title)
                      .font(.body)
                      .padding(.horizontal)
                  }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 115)
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding(.top, 15.0)
                    .padding(.horizontal, 20.0)
//                }
              }
            } else {
              VStack {
                Text("Let's start adding to your favorites :)")
              }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 550)
              .background(Color.white)
              .cornerRadius(15)
              .padding(.top, 15.0)
              .padding(.horizontal, 20.0)
            }
//          }
              Spacer()
            }
        }
          
      }.navigationBarTitle("Favorites", displayMode: .inline).font(.title2)
    }.navigationViewStyle(StackNavigationViewStyle())
  }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
          .environmentObject(Favorites())
    }
}
