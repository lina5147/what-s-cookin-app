//
//  NoResults.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/15/21.
//

import SwiftUI

struct NoResults: View {
    var body: some View {
      VStack {
        Image("SadMagnifyingGlass")
          .resizable()
          .frame(width: 145.0, height: 150.0)
          .padding(.bottom, 20)
        Text("No results found")
          .font(Font.custom("Righteous-Regular", size: 20))
          .foregroundColor(Color.black)
          .padding(.bottom, 5)
        Text("We did not find any recipes for your search. \n Please try again.")
          .font(Font.custom("ReemKufi-Regular", size: 17))
          .foregroundColor(Color.black)
          .padding(.horizontal, 15)
          .multilineTextAlignment(.center)
      }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 635)
      .background(Color.white)
      .cornerRadius(15)
      .padding(.top, 15.0)
      .padding(.horizontal, 20.0)
    }
}

struct NoResults_Previews: PreviewProvider {
    static var previews: some View {
        NoResults()
    }
}
