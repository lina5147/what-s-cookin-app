//
//  NoFavorites.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/15/21.
//

import SwiftUI

struct NoFavorites: View {
    var body: some View {
      VStack {
        Image("cooking")
          .resizable()
          .frame(width: 145.0, height: 145.0)
          .padding(.bottom, 20)
        Text("No Favorite Recipes Yet!")
          .font(Font.custom("Righteous-Regular", size: 20))
          .foregroundColor(Color.black)
          .padding(.bottom, 5)
        HStack {
          Text("Use the")
            .font(Font.custom("ReemKufi-Regular", size: 17))
            .foregroundColor(Color.black)
          Image(systemName: "heart").foregroundColor(.red).font(Font.system(size: 24, weight: .semibold))
          Text("button")
            .font(Font.custom("ReemKufi-Regular", size: 17))
            .foregroundColor(Color.black)
        }
        Text("to save to your favorites.")
          .font(Font.custom("ReemKufi-Regular", size: 17))
          .foregroundColor(Color.black)
          .padding(.horizontal, 15)
          .multilineTextAlignment(.center)
      }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 620)
        .padding(.top, 15)
        .padding(.horizontal, 15)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct NoFavorites_Previews: PreviewProvider {
    static var previews: some View {
        NoFavorites()
    }
}
