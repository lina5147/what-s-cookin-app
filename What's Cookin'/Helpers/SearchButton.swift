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
        .frame(width: 200, height: 50)
        .background(Color.yellow)
        .foregroundColor(Color.black)
        .cornerRadius(10)
    }
}

struct SearchButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchButton()
    }
}
