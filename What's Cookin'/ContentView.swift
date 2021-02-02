//
//  ContentView.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var ingredients = [String]()
    @State private var ingredient = ""
  
    var body: some View {
      NavigationView {
        Form {
          Section {
            HStack {
              TextField("Enter Ingredient", text: $ingredient)
                .multilineTextAlignment(TextAlignment.center)
                
              Button(action: {
                if ingredient != "" {
                  self.ingredients.append(ingredient)
                }
                self.ingredient = ""
                print(ingredients)
              }) {Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.blue)}
            }

          }
          Section {
              ForEach(ingredients, id: \.self) { ingredient in
                  Text(ingredient)
              }
          }
        }
      }
    }
  }



//class IngredientsList : ObservableObject {
//  @Published var ingrediants = [String]()
//
//  init() {
//    addIngrediant
//  }
//
//
//
//
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
