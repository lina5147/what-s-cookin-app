//
//  SearchButton.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
      Text("Search for Recipes")
        .font(Font.custom("ReemKufi-Regular", size: 17))
        .frame(width: 160, height: 45)
        .background(Color.yellow.opacity(0.6))
        .foregroundColor(Color.black)
        .cornerRadius(10)
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton()
    }
}
