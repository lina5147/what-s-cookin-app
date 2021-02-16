//
//  ClearButton.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/15/21.
//

import SwiftUI

struct ClearButton: View {
    var body: some View {
      Text("Clear")
          .font(Font.custom("ReemKufi-Regular", size: 17))
          .frame(width: 160, height: 45)
          .foregroundColor(Color.black)
          .border(Color.yellow.opacity(0.6), width: 5)
          .cornerRadius(10)
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton()
    }
}
