//
//  RecipeDetails.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI
import URLImage

struct RecipeDetails: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: SavedRecipe.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \SavedRecipe.title, ascending: true),
        ]
    ) var savedRecipeList: FetchedResults<SavedRecipe>
    @State var extraDetails = [Details]()
    var id: Int
    var title: String
    var image: String
    @State var dailyLimit = false
  
  
    var body: some View {
      ZStack{
        Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
        ScrollView{
          VStack{
            VStack{
              ZStack (alignment: .bottomTrailing){
              let url = URL(string: image)!
              URLImage(url: url, content: { image in
                  image
                      .resizable()
                      .aspectRatio(contentMode: .fit)
              })
                if !extraDetails.isEmpty{
                  Text("Credit: \(extraDetails[0].credit)")
                    .font(Font.custom("ReemKufi-Regular", size: 14))
                    .padding(.horizontal, 2)
                    .background(Color.white).opacity(0.5)
                }
              }
              HStack {
                Spacer()
                if !checkIfItemExist(id: self.id) {
                  Button(action: addRecipe) {
                    Image(systemName: "heart").foregroundColor(.red).padding(6.0).font(Font.system(size: 30, weight: .semibold))
                  }
                } else {
                  Button(action: removeFromFavorites) {
                    Image(systemName: "heart.fill").foregroundColor(.red).padding( 6.0).font(Font.system(size: 30, weight: .semibold))
                  }
                }
              }
                Text(title)
                  .foregroundColor(Color.black)
                  .padding(.horizontal, 52)
                  .padding(.bottom, 12.0)
                  .padding(.top, -42)
                  .font(Font.custom("ReemKufi-Regular", size: 22))
                  .multilineTextAlignment(.center)
              if dailyLimit {Text("Daily limit Reached")}
              
              if !extraDetails.isEmpty {
                VStack(alignment: .leading, spacing: 10)  {
                  Text("Ingredients:")
                    .foregroundColor(Color.black)
                    .font(Font.custom("Righteous-Regular", size: 18))
                    .padding(.leading, 4)
                  ForEach(extraDetails, id: \.self) { item in
                    ForEach(item.ingredients, id: \.self) { ingredient in
                      Text(" •  " + ingredient)
                        .foregroundColor(Color.black)
                        .font(Font.custom("ReemKufi-Regular", size: 17))
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                  }
                }.frame(width: 350, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 20)  {
                  Text("Instructions:")
                    .foregroundColor(Color.black)
                    .font(Font.custom("Righteous-Regular", size: 18))
                    .padding(.leading, 4)
                  ForEach(extraDetails, id: \.self) { item in
                    if item.instructions.isEmpty {
                      Text("No instructions available for recipe.")
                        .foregroundColor(Color.black)
                        .font(Font.custom("ReemKufi-Regular", size: 18))
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    } else {
                    ForEach(0..<item.instructions.count) {
                      Text("\($0 + 1).   " + item.instructions[$0])
                        .foregroundColor(Color.black)
                        .font(Font.custom("ReemKufi-Regular", size: 18))
                        .padding(.horizontal)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    
                  }
                }
              }.frame(width: 350, alignment: .leading)
              .padding()
              }
              Spacer()

            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 700)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.top, 15.0)
                .padding(.leading, 20.0)
            
          }
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 700)
              .background(Color.yellow.opacity(0.9))
              .cornerRadius(15)
              .padding(.top, 15.0)
              .padding(.leading, 10.0)
          
      .onAppear(perform: loadData)
        }.navigationBarTitle("Recipe", displayMode: .inline)
      }.navigationViewStyle(StackNavigationViewStyle())
    }
// check if recipe is already saved to favorites
  func checkIfItemExist(id: Int) -> Bool {
    for item in savedRecipeList {
      if Int(item.id) == id {
        return true
      }
    }
    return false
  }
  
  func removeFromFavorites() {
    for item in savedRecipeList {
      if Int(item.id) == self.id {
        managedObjectContext.delete(item)
        break
      }
    }
    PersistenceController.shared.saveContext()
  }
  
  func addRecipe() {
    let favoriteRecipe = SavedRecipe(context: managedObjectContext)
    favoriteRecipe.id = Int32(self.id)
    favoriteRecipe.title = self.title
    favoriteRecipe.image = self.image
    
    PersistenceController.shared.saveContext()
  }
  
  func loadData() {
    dailyLimit = false
    guard let url = URL(string: "https://whatscookin-api.herokuapp.com/search/\(self.id)") else {
        print("Invalid URL")
        return
    }
    print(url)
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([Details].self, from: data) {
          DispatchQueue.main.async {
            self.extraDetails = decodedResponse
            print(decodedResponse)
//            print(extraDetails)
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Daily Points used for Spoonacular API")")
      dailyLimit = true
    }.resume()
  }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
      RecipeDetails(id: 660837, title: "Spaghetti With Smoked Salmon and Prawns", image: "https://spoonacular.com/recipeImages/660837-312x231.jpg")
    }
}
