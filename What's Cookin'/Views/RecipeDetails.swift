//
//  RecipeDetails.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/3/21.
//

import SwiftUI
import URLImage

struct Details: Codable, Hashable {
  var ingredients: [String]
  var instructions: [String]
}


struct RecipeDetails: View {
  @State var extraDetails = [Details]()
    var id: Int
    var title: String
    var image: String
  
  
    var body: some View {
      ZStack{
        Color(UIColor.systemTeal).edgesIgnoringSafeArea(.all).opacity(0.9)
        ScrollView{
          VStack{
            VStack{
              let url = URL(string: image)!
              URLImage(url: url, content: { image in
                  image
                      .resizable()
                      .aspectRatio(contentMode: .fit)
              })
              Text(title)
                .padding(.horizontal)
                .padding(.vertical, 12.0)
                .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
              

              VStack(alignment: .leading, spacing: 10)  {
                Text("Ingredients:").font(.title3)
                ForEach(extraDetails, id: \.self) { item in
                  ForEach(item.ingredients, id: \.self) { ingredient in
                    Text(" •  " + ingredient)
                      .font(.body)
                      .padding(.horizontal)
                      .fixedSize(horizontal: false, vertical: true)
                  }
                }
              }.frame(width: 350, alignment: .leading)
              .background(Color.gray.opacity(0.1))
              
              VStack(alignment: .leading, spacing: 25)  {
                Text("Instructions:").font(.title3)
                ForEach(extraDetails, id: \.self) { item in
                  ForEach(0..<item.instructions.count) {
                    Text("\($0 + 1).   " + item.instructions[$0])
                      .font(.body)
                      .padding(.horizontal)
                      .fixedSize(horizontal: false, vertical: true)
                  }
                }
              }.frame(width: 350, alignment: .leading)
              .background(Color.gray.opacity(0.1))
              .padding()
              
              
              
              Spacer()

            }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 700)
                .background(Color.white)
                .cornerRadius(15)
                .padding(.top, 15.0)
                .padding(.leading, 20.0)
          }
              .frame(minWidth: 0, maxWidth: .infinity, minHeight: 700)
          .background(Color.yellow.opacity(0.9))
              .cornerRadius(15)
              .padding(.top, 18.0)

   
        }.onAppear(perform: loadData)
      }
      .navigationBarTitle("Recipe", displayMode: .inline).font(.title2)
      
    }
  
  func loadData() {

    guard let url = URL(string: "http://127.0.0.1:5000/search/\(self.id)") else {
        print("Invalid URL")
        return
    }
    print(url)
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([Details].self, from: data) {
          DispatchQueue.main.async {
            self.extraDetails = decodedResponse
            print(decodedResponse)
            print(extraDetails)
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }
}

struct RecipeDetails_Previews: PreviewProvider {
    static var previews: some View {
      RecipeDetails(id: 246428, title: "Chicken Pot Pie", image: "https://spoonacular.com/recipeImages/641901-312x231.jpg")
    }
}
