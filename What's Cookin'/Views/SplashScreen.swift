//
//  SplashScreen.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/15/21.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
      ZStack {
        Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all)
        Text("What's Cookin'")
          .font(.largeTitle)
          .foregroundColor(.white)
//          .offset(x: 20,
//                  y: 0)
        
  //      Spacer()
      }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
