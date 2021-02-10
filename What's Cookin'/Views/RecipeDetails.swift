//
//  RecipeDetails.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI
import URLImage

struct Details: Codable, Hashable {
  var ingredients: [String]
  var instructions: [String]
}


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
  
  
    var body: some View {
      ZStack{
        Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
        ScrollView{
          VStack{
            VStack{
              let url = URL(string: image)!
              URLImage(url: url, content: { image in
                  image
                      .resizable()
                      .aspectRatio(contentMode: .fit)
              })
              HStack {
                Spacer()
                if !checkIfItemExist(id: self.id) {
                  Button(action: addRecipe) {
                    Image(systemName: "heart").foregroundColor(.red).padding(.trailing, 5.0).font(.system(size: 26))
                  }
                } else {
                  Button(action: removeFromFavorites) {
                    Image(systemName: "heart.fill").foregroundColor(.red).padding(.trailing, 5.0).font(.system(size: 26))
                  }
                }
            }
//                Spacer()
                Text(title)
                  .padding(.horizontal)
                  .padding(.bottom, 12.0)
                  .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                  .multilineTextAlignment(.center)

//              }

              VStack(alignment: .leading, spacing: 10)  {
                Text("Ingredients:").font(.title3).fontWeight(.bold)
                ForEach(extraDetails, id: \.self) { item in
                  ForEach(item.ingredients, id: \.self) { ingredient in
                    Text(" •  " + ingredient)
                      .font(.body)
                      .padding(.horizontal)
                      .fixedSize(horizontal: false, vertical: true)
                  }
                }
              }.frame(width: 350, alignment: .leading)

              
              VStack(alignment: .leading, spacing: 20)  {
                Text("Instructions:").font(.title3).fontWeight(.bold)
                ForEach(extraDetails, id: \.self) { item in
                  ForEach(0..<item.instructions.count) {
                    Text("\($0 + 1).   " + item.instructions[$0])
                      .font(.body)
                      .padding(.horizontal)
                      .fixedSize(horizontal: false, vertical: true)
                  }
                }
              }.frame(width: 350, alignment: .leading)
//              .background(Color.gray.opacity(0.1))
              .padding()
              
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
        }.navigationBarTitle("Recipe", displayMode: .inline).font(.title2)
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

    guard let url = URL(string: "http://127.0.0.1:5000/search/\(self.id)") else {
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
//            print(decodedResponse)
//            print(extraDetails)
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
      RecipeDetails(id: 660837, title: "Spaghetti With Smoked Salmon and Prawns", image: "https://spoonacular.com/recipeImages/660837-312x231.jpg")
    }
}
