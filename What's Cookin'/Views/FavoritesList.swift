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
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(
      entity: SavedRecipe.entity(),
      sortDescriptors: [
          NSSortDescriptor(keyPath: \SavedRecipe.title, ascending: true),
      ]
  ) var savedRecipeList: FetchedResults<SavedRecipe>

    var body: some View {
      NavigationView{
        ZStack {
          Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
//          ScrollView{
            VStack {
//            if !favorites.favoriteRecipes.isEmpty {
              List {
                ForEach(savedRecipeList, id: \.self) { recipe in
                  HStack {
                    let url = URL(string: recipe.image ?? "unknown")!
                    URLImage(url: url) { image in
                      image
                          .resizable()
                          .cornerRadius(8)
                        .frame(width: 75, height: 70)
                        .padding(.horizontal, 8.0)
//                          .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    VStack (alignment: .leading) {
                      Text(recipe.title ?? "unknown")
                      .font(.body)
                        .padding(.trailing, 8.0)
                    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                  }.padding(.top, 5)
                  .padding(.bottom, 5)
//                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: 115)
//                    .background(Color.white)
//                    .cornerRadius(15)
//                    .padding(.bottom, 8.0)
//                    .padding(.horizontal, 20.0)

                
                }.onDelete(perform: deleteRecipe)
              }.cornerRadius(15)
//            }
//            else {
//              VStack {
//                Text("Let's start adding to your favorites :)")
//              }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 550)
              // add a picture?? 
//              .background(Color.white)
//              .cornerRadius(15)
////              .padding(.top, 15.0)
//              .padding(.horizontal, 20.0)
//            }
//          }
              Spacer()
            }.padding(.top, 15.0)
            .padding(.horizontal, 20.0)
//        }
          
      }.navigationBarTitle("Favorites", displayMode: .inline).font(.title2)
    }.navigationViewStyle(StackNavigationViewStyle())
  }

  func deleteRecipe(at offsets: IndexSet) {
    favorites.favoriteRecipes.remove(atOffsets: offsets)
  }
  
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
          .environmentObject(Favorites())
    }
}
