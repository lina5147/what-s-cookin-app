//
//  FavoritesList.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/8/21.
//

import SwiftUI
import URLImage

struct FavoritesList: View {
  
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
          VStack {
              if !savedRecipeList.isEmpty {
                List {
                  ForEach(savedRecipeList, id: \.self) { recipe in
                    NavigationLink (destination: RecipeDetails(id: Int(recipe.id), title: recipe.title ?? "unknown", image: recipe.image ?? "unknown")) {
                      HStack {
                        let url = URL(string: recipe.image ?? "unknown")!
                        URLImage(url: url) { image in
                          image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(width: 80, height: 80)
                            .padding(.horizontal, 2.0)
                        }
                        Spacer()
                        VStack (alignment: .leading) {
                          Text(recipe.title ?? "unknown")
                            .font(Font.custom("ReemKufi-Regular", size: 17))
                            .padding(.trailing, 8.0)
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                      }.padding(.vertical, 5)
                    }
                  }.onDelete(perform: deleteRecipe)
                }.cornerRadius(15)
              }
              else {
                ScrollView {
                  NoFavorites()
                }
              }
          }
          .padding(.vertical, 15.0)
          .padding(.horizontal, 20.0)
      }.navigationBarTitle("Favorites", displayMode: .inline)
    }.navigationViewStyle(StackNavigationViewStyle())
  }

  func deleteRecipe(at offsets: IndexSet) {
    for index in offsets {
            let recipe = savedRecipeList[index]
            managedObjectContext.delete(recipe)
        }
    PersistenceController.shared.saveContext()
  }
}

struct FavoritesList_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesList()
    }
}
