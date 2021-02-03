//
//  Search.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//

import SwiftUI

struct Search: View {
  //  init(){
  //      UITableView.appearance().backgroundColor = .clear
  //  }
      @State private var ingredients = [String]()
      @State private var ingredient = ""
    
      var body: some View {
        NavigationView {
          Form {
            Section {
              HStack {
                TextField("Enter Ingredient", text: $ingredient)
                  .multilineTextAlignment(TextAlignment.center)
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                  
                Button(action: {
                  self.addIngredient()
                }) {Image(systemName: "plus")
                  .font(.largeTitle)
                  .foregroundColor(.blue)}
              }

            }
            Section(header: Text("Ingredients List:").font(.title2)) {
                ForEach(ingredients, id: \.self) { ingredient in
                  HStack {
                    Text(ingredient).font(.title2)
                    Spacer()
                    Button(action: {
                      self.deleteIngredient(ingredient: ingredient)
                    }){
                      Image(systemName: "trash")
                        .font(.title2)
                        .padding(10.0)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(40)
                    }
                  }
                }
            }
            Section {
                Button(action: {
                  ingredients = [String]()
                  ingredient = ""
                }){
                  Text("Clear")
                }
              
              NavigationLink(destination: SearchResults(ingredients: $ingredients)) {
                Text("Search for Recipes")
              }
            }
//            NavigationLink(destination: SearchResults()) {
//              Text("click")
//            }.buttonStyle(PlainButtonStyle())
//            NavigationLink(destination: SearchResults()) {
//              SearchButton()
//            }
          }
          .navigationBarTitle("Search")
        }

      }
    
    func addIngredient() {
      if ingredient != "" && !ingredients.contains(ingredient.lowercased()) {
        self.ingredients.append(ingredient.lowercased())
      }
      self.ingredient = ""
      print(ingredients)
    }
    
    func deleteIngredient(ingredient: String) {
      print(ingredient)
      ingredients = ingredients.filter(){$0 != ingredient}
      print(ingredients)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
