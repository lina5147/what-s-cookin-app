//
//  Search.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//

import SwiftUI

struct Search: View {
      @State private var ingredients = [String]()
      @State private var ingredient = ""
    
      var body: some View {
        NavigationView{
          ZStack {
            Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.8)
            VStack {
              VStack{
                Text("Let's Explore!").font(.title2).padding(.top, 11.0)
                Text("Add ingredients to the ingredients list. When you are ready to see what recipes we have for the ingredients you have listed, tap on search for recipes.").font(.title3).multilineTextAlignment(.center).padding(.horizontal, 16.0).padding(.top, 3.0)
                HStack {
                  TextField("Enter Ingredient", text: $ingredient)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(TextAlignment.center)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .padding()
                  Button(action: {
                    self.addIngredient()
                  }) {Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.blue)}
                }
                Text("Ingredients List:")
                  .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                Section() {
                    ForEach(ingredients, id: \.self) { ingredient in
                      HStack {
                        Text(ingredient)
                          .font(.title2)
                          .padding()
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
                Spacer()
                HStack(alignment: .bottom){
                    Button(action: {
                      ingredients = [String]()
                      ingredient = ""
                    }){
                      Text("Clear")
                        .font(.title2)
                        .frame(width: 160, height: 50)
                        .foregroundColor(Color.black)
                        .background(Color.white)
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
            }.navigationTitle("Search")
            
            
            
  //          Form {
  //            Section {
  //              HStack {
  //                TextField("Enter Ingredient", text: $ingredient)
  //                  .multilineTextAlignment(TextAlignment.center)
  //                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
  //
  //                Button(action: {
  //                  self.addIngredient()
  //                }) {Image(systemName: "plus")
  //                  .font(.largeTitle)
  //                  .foregroundColor(.blue)}
  //              }
  //
  //            }
  //            Section(header: Text("Ingredients List:").font(.title2)) {
  //                ForEach(ingredients, id: \.self) { ingredient in
  //                  HStack {
  //                    Text(ingredient).font(.title2)
  //                    Spacer()
  //                    Button(action: {
  //                      self.deleteIngredient(ingredient: ingredient)
  //                    }){
  //                      Image(systemName: "trash")
  //                        .font(.title2)
  //                        .padding(10.0)
  //                        .foregroundColor(.white)
  //                        .background(Color.red)
  //                        .cornerRadius(40)
  //                    }
  //                  }
  //                }
  //            }
  //            Section {
  //                Button(action: {
  //                  ingredients = [String]()
  //                  ingredient = ""
  //                }){
  //                  Text("Clear")
  //                }
  //
  //              NavigationLink(destination: SearchResults(ingredients: $ingredients)) {
  //                Text("Search for Recipes")
  //              }
  //            }
  ////            NavigationLink(destination: SearchResults()) {
  ////              Text("click")
  ////            }.buttonStyle(PlainButtonStyle())
  ////            NavigationLink(destination: SearchResults()) {
  ////              SearchButton()
  ////            }
  //          }
  //          .navigationBarTitle("Search")
  //          }
            }
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
