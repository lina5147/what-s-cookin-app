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
              .foregroundColor(Color.white)
              .opacity(0.9)

            VStack(spacing: -10){
                Text("What's")
                Text("Cookin'")
              }
              .font(Font.custom("PetitFormalScript-Regular", size: 60))
              .font(.largeTitle)
              .foregroundColor(.white)
              .opacity(0.9)
        }.offset(
        x: 0,
          y: -40)
      }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
