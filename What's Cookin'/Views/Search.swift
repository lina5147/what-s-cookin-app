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

  
//  init() {
//          let appearance = UINavigationBarAppearance()
//
//          // this overrides everything you have set up earlier.
//          appearance.configureWithTransparentBackground()
//
//          // this only applies to big titles
//          appearance.largeTitleTextAttributes = [
//              .font : UIFont.systemFont(ofSize: 20),
//              NSAttributedString.Key.foregroundColor : UIColor.black
//          ]
//          // this only applies to small titles
//          appearance.titleTextAttributes = [
//              .font : UIFont.systemFont(ofSize: 25),
//              NSAttributedString.Key.foregroundColor : UIColor.black
//          ]
//
//          //In the following two lines you make sure that you apply the style for good
//          UINavigationBar.appearance().scrollEdgeAppearance = appearance
//          UINavigationBar.appearance().standardAppearance = appearance
//
//          // This property is not present on the UINavigationBarAppearance
//          // object for some reason and you have to leave it til the end
//          UINavigationBar.appearance().tintColor = .white
//
//      }
  
    
      var body: some View {
        NavigationView{
          

          ZStack {
            Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
            ScrollView{
              VStack{
                Text("Let's Explore!")
                  .font(Font.custom("ReemKufi-Regular", size: 25))
                  .padding(.top, 11.0)
                Text("Add ingredients to the ingredients list. When you are ready to see what recipes we have for the ingredients you have listed, tap on search for recipes.")
                    .font(Font.custom("ReemKufi-Regular", size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16.0).padding(.top, 3.0)
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
                Text("Ingredients List:")
                  .font(Font.custom("ReemKufi-Regular", size: 24))
                  .padding(.bottom, 1)
                Section {
                    ForEach(ingredients, id: \.self) { ingredient in
                      Section {
                      HStack {
                        Button(action: {
                          self.deleteIngredient(ingredient: ingredient)
                        }){
                        Text(ingredient)
                            .font(Font.custom("ReemKufi-Regular", size: 24))
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40)
                            .foregroundColor(Color.black)
                          Spacer()
                          Image(systemName: "multiply.circle")
                                    .font(.title)
                                    .foregroundColor(.red)
                                    .padding(.trailing, 10)
                        }.background(Color.yellow.opacity(0.3))
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
              .padding(.horizontal, 20.0)
              .padding(.top, 15.0)
               .frame(minHeight: 650)
            }
        }
          .navigationBarTitle("Search", displayMode: .inline)
          
      }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func addIngredient() {
      if text != "" && !ingredients.contains(text.lowercased()) {
        self.ingredients.append(text.lowercased())
      }
      self.text = ""
//      print(ingredients)
    }
    
    func deleteIngredient(ingredient: String) {
//      print(ingredient)
      ingredients = ingredients.filter(){$0 != ingredient}
//      print(ingredients)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
          .environmentObject(Favorites())
    }
}
