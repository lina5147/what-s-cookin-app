//
//  FullRecipe.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI

struct FullRecipeButton: View {
    var body: some View {
      Text("View Recipe")
        .font(Font.custom("ReemKufi-Regular", size: 17))
        .frame(width: 160, height: 30)
        .background(Color.yellow.opacity(0.6))
        .foregroundColor(Color.black)
        .cornerRadius(10)
    }
}

struct FullRecipeButton_Previews: PreviewProvider {
    static var previews: some View {
        FullRecipeButton()
    }
}
