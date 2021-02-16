//
//  IngredientBar.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI

struct IngredientBar: View {
    @Binding var text: String
   
    var body: some View {
        TextField("Enter Ingredient", text: $text)
            .font(Font.custom("ReemKufi-Regular", size: 20))
            .multilineTextAlignment(TextAlignment.center)
            .padding(4)
            .background(Color(.lightGray).opacity(0.5))
            .cornerRadius(25)
            .padding(.leading, 8)
      }
}

struct IngredientBar_Previews: PreviewProvider {
    static var previews: some View {
      IngredientBar(text: .constant(""))
    }
}
