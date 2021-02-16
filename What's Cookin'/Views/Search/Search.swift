//
//  Search.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//

import SwiftUI

struct Search: View {
    @State private var ingredients = [String]()
    @State private var text = ""

    var body: some View {
      NavigationView{
        ZStack {
          Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
          ScrollView{
            VStack{
              VStack{
                Text("Let's Explore!")
                  .font(Font.custom("ReemKufi-Regular", size: 22))
                  .padding(.top, 11.0)
                Text("Add ingredients to the ingredient list. When you are ready to see what recipes we have for the ingredients you have listed, tap on search for recipes.")
                    .font(Font.custom("ReemKufi-Regular", size: 18))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16.0).padding(.top, 3.0)
              }.foregroundColor(Color.black)
              HStack {
                IngredientBar(text: $text).padding(.vertical)
                Button(action: {
                    self.addIngredient()
                  }) {
                    Image(systemName: "plus.circle.fill")
                      .font(.largeTitle)
                      .foregroundColor(.blue)
                      .padding(.trailing, 10)
                  }
              }
              Text("Ingredient List:  ")
                .font(Font.custom("ReemKufi-Regular", size: 22))
                .foregroundColor(Color.black)
                .padding(.bottom, 1)
              Section {
                ForEach(ingredients, id: \.self) { ingredient in
                  Section {
                    HStack {
                      Button(action: {
                        self.deleteIngredient(ingredient: ingredient)
                      }){
                        Text(ingredient)
                            .font(Font.custom("ReemKufi-Regular", size: 20))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                            .foregroundColor(Color.black)
                        Spacer()
                        Image(systemName: "multiply.circle")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .padding(.trailing, 10)
                      }
                         .background(Color.yellow.opacity(0.3))
                         .cornerRadius(10)
                         .padding(.bottom, 1.0)
                         .padding(.horizontal, 10.0)
                      }
                    }
                  }
                }
                Spacer()
                HStack(alignment: .bottom){
                    Button(action: {
                      ingredients = [String]()
                      text = ""
                    }){
                      ClearButton()
                    }
                    NavigationLink(destination: SearchResults(ingredients: self.$ingredients)) {
                        SearchButton()
                    }
                }.padding(.bottom, 8.0)
              }
               .background(Color.white)
               .cornerRadius(15)
               .padding(.horizontal, 20.0)
               .padding(.top, 15.0)
               .frame(minHeight: 540)
          }
        }
          .navigationBarTitle("Search", displayMode: .inline)
      }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addIngredient() {
      let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
      if trimmed != "" && !ingredients.contains(trimmed.lowercased()) {
        self.ingredients.append(trimmed.lowercased())
      }
      self.text = ""
    }
    
    func deleteIngredient(ingredient: String) {
      ingredients = ingredients.filter(){$0 != ingredient}
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
