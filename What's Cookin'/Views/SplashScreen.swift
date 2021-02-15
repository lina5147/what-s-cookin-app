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
        VStack (spacing: 3){
            Image("chefHat")
              .resizable()
              .scaledToFit()
              .frame(width: 170.0, height:170)
              .opacity(0.7)
            VStack(spacing: -8){
                Text("What's")
                Text("Cookin'")
              }
              .font(Font.custom("PetitFormalScript-Regular", size: 55))
              .font(.largeTitle)
              .foregroundColor(.black)
              .opacity(0.7)
        }
      }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
