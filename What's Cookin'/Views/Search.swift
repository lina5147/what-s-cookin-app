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
            VStack {
              VStack{
                Text("Let's Explore!").font(.title2).padding(.top, 11.0)
                Text("Add ingredients to the ingredients list. When you are ready to see what recipes we have for the ingredients you have listed, tap on search for recipes.")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16.0).padding(.top, 3.0)
                HStack {
                  IngredientBar(text: $text).padding(.vertical)
                  Button(action: {
                    self.addIngredient()
                  }) {
                    Image(systemName: "plus.circle.fill")
                      .font(.title)
                      .foregroundColor(.gray)
                      .padding(.trailing, 10)
                  }
                }
                Text("Ingredients List:").font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Section {
                    ForEach(ingredients, id: \.self) { ingredient in
                      HStack {
                        Text(ingredient)
                            .font(.title2)
                            .padding()
                        Spacer()
                        Button(action: {
                          self.deleteIngredient(ingredient: ingredient)
                        }){
                          Image(systemName: "multiply.circle")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding(.trailing, 10)
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
                      Text("Clear")
                          .font(.title2)
                          .frame(width: 160, height: 50)
                          .foregroundColor(Color.black)
                          .border(Color.yellow.opacity(0.6), width: 5)
                          .cornerRadius(10)
                    }
                    NavigationLink(destination: SearchResults(ingredients: self.$ingredients)) {
                        SearchButton()
                    }
                }.padding(.bottom)
              }.background(Color.white)
               .cornerRadius(25)
               .padding(.horizontal, 25.0)
               .frame(minHeight: 600)
            }.navigationTitle("Search")
          }
        }
      }
    }
    
    func addIngredient() {
      if text != "" && !ingredients.contains(text.lowercased()) {
        self.ingredients.append(text.lowercased())
      }
      self.text = ""
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
