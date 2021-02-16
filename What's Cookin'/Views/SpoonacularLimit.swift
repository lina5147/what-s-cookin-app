//
//  SpoonacularLimit.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/15/21.
//

import SwiftUI

struct SpoonacularLimit: View {
    var body: some View {
      VStack {
        Image("spoonacular-logo")
          .resizable()
          .scaledToFit()
          .frame(width: 90, height: 90)
        Text("Daily limit reached for Spoonacular requests.\nPlease try again tomorrow.")
          .foregroundColor(Color.black)
            .font(Font.custom("ReemKufi-Regular", size: 17))
          .padding()
          .multilineTextAlignment(.center)
      }
    }
}

struct SpoonacularLimit_Previews: PreviewProvider {
    static var previews: some View {
        SpoonacularLimit()
    }
}
