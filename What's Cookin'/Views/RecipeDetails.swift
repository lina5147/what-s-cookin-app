//
//  RecipeDetails.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI
import URLImage

struct RecipeDetails: View {
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
              Text(title)
                  .padding(.horizontal)
                  .padding(.top, 25.0)
                  .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                  .multilineTextAlignment(.center)
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
              .padding(.top, 50.0)

   
        }
      }
    }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
      RecipeDetails(id: 246428, title: "Chicken Pot Pie", image: "https://spoonacular.com/recipeImages/641901-312x231.jpg")
    }
}
