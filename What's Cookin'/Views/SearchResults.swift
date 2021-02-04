//
//  SearchResults.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//


import SwiftUI
import URLImage

struct Recipe: Codable, Identifiable, Hashable {
//  enum CodingKeys: String, CodingKey {
//      case id
//      case title
//      case image
//      case additionalIngredients = "missedIngredients"
//  }
  
  var id: Int
  var title: String
  var image: String
  var additionalIngredients: [String]

}

//struct Ingredients: Codable, Hashable {
//  var name: String
//}

struct SearchResults: View {
  @Binding var ingredients: [String]
  @State var recipes = [Recipe]()
  @State var anyRecipes = true
  
    var body: some View {
//      NavigationView {
        ZStack {
          Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
          ScrollView {
            VStack {
              if !recipes.isEmpty {
                ForEach(recipes, id: \.id) { item in

                    VStack {
                      Text(item.title)
                        .padding(.horizontal)
                        .padding(.top, 25.0)
                        .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                      let url = URL(string: item.image)!
                      URLImage(url: url, content: { image in
                          image
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
                              .cornerRadius(15)
                              .padding(.horizontal, 20.0)
                      })
                      Text("Additional Ingredients:").font(.title3).fontWeight(.bold).padding(.vertical, 3.0)
                      ForEach(item.additionalIngredients, id: \.self) { item in
                        Text(item).font(.body)
                      }
                      Spacer()
                      NavigationLink(destination: RecipeDetails(id: item.id, title: item.title, image: item.image)) {
                          FullRecipeButton()
                      }.padding(.vertical)
                    }
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 550)
                  .background(Color.white)
                  .cornerRadius(15)
                  .padding(.top, 15.0)
                  .padding(.horizontal, 20.0)
              }}.onAppear(perform: loadData)
            if anyRecipes == false {
              VStack {
                Text("No results found...")
//                Text("Suggestions:")
//                Text("- Make sure all ingredients are spelled correctly")
//                Text("- Check to make sure ingredients are added to the list")
              }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 550)
              .background(Color.white)
              .cornerRadius(15)
              .padding(.top, 15.0)
              .padding(.horizontal, 20.0)
            }
          }
          .navigationBarTitle("Search Results", displayMode: .inline).font(.title2)
//        }
      }
    }
  
  func loadData() {
    if ingredients.isEmpty {
      anyRecipes = false
      return
    }
    var ingredientsString = ""
    for i in self.ingredients {
      ingredientsString += "\(i),"
    }
    
    print(ingredientsString)
    guard let url = URL(string: "http://127.0.0.1:5000/search/\(ingredientsString)") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([Recipe].self, from: data) {
          DispatchQueue.main.async {
            self.recipes = decodedResponse
            if recipes.isEmpty {
              anyRecipes = false
            } else {
              anyRecipes = true
            }
            print(decodedResponse)
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }
  
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
      SearchResults(ingredients: .constant(["tomato", "chicken", "carrot"]))
    }
}
