//
//  SearchResults.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//


import SwiftUI
import URLImage
import Combine

struct SearchResults: View {
  @Binding var ingredients: [String]
  @State var recipes = [Recipe]()
  @State var anyRecipes = true
  
    var body: some View {
        ZStack {
          Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
          ScrollView {
            VStack {
              if !recipes.isEmpty {
                ForEach(recipes, id: \.id) { item in

                    VStack {
                      Text(item.title)
                        .foregroundColor(Color.black)
                        .padding(.horizontal)
                        .padding(.top, 20.0)
                        .font(Font.custom("ReemKufi-Regular", size: 22))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                      let url = URL(string: item.image)!
                      URLImage(url: url, content: { image in
                          image
                              .cornerRadius(15)
                              .padding(.horizontal, 20.0)
                      })
                      Text("Additional Ingredients:")
                        .foregroundColor(Color.black)
                        .font(Font.custom("Righteous-Regular", size: 18))
                        .fontWeight(.bold)
                        .padding(.vertical, 3.0)
                      ForEach(item.additionalIngredients, id: \.self) { item in
                        Text(item)
                          .foregroundColor(Color.black)
                          .font(Font.custom("ReemKufi-Regular", size: 18))
                      }
                      Spacer()
                      NavigationLink(destination: RecipeDetails(id: item.id, title: item.title, image: item.image)) {
                          FullRecipeButton()
                      }.padding()
                    }
                    
                }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: 1000)
                  .background(Color.white)
                  .cornerRadius(15)
                  .padding(.top, 15.0)
                  .padding(.horizontal, 20.0)
              }}.onAppear(perform: loadData)
            if anyRecipes == false {
              VStack {
                Text("No results found...")
                .foregroundColor(Color.black)
              }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 635)
              .background(Color.white)
              .cornerRadius(15)
              .padding(.top, 15.0)
              .padding(.horizontal, 20.0)
            }
          }
          .navigationBarTitle("Search Results", displayMode: .inline)
      }
        .navigationViewStyle(StackNavigationViewStyle())
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
    
    //takes care of spaces
    let newString = ingredientsString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//    print(newString)
    guard let url = URL(string: "https://whatscookin-api.herokuapp.com/search?ingredients=\(newString)") else {
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
//            print(decodedResponse)
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
      SearchResults(ingredients: .constant(["tomato", "chicken", "onion"]))
    }
}
