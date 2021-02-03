//
//  SearchResults.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/2/21.
//


import SwiftUI

struct Recipe: Codable {
  enum CodingKeys: String, CodingKey {
      case id
      case title
      case image
      case additionalIngredients = "missedIngredients"
  }
  
  var id: Int
  var title: String
  var image: String
  var additionalIngredients: [Ingredients]

}

struct Ingredients: Codable {
  var name: String
}

struct SearchResults: View {
  @Binding var ingredients: [String]
  @State var recipes = [Recipe]()
    var body: some View {
      List(recipes, id: \.id) { item in
        VStack(alignment: .leading) {
          Text(item.title)
          Text(item.image)
          Text(item.additionalIngredients[0].name)
        }
      }
      .onAppear(perform: loadData)
    }
  
  func loadData() {
    var ingredientsString = ""
    for i in self.ingredients {
      ingredientsString += "\(i),"
    }
    
    print(ingredientsString)
    guard let url = URL(string: "http://127.0.0.1:5000/search/\(ingredientsString)") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        if let decodedResponse = try? JSONDecoder().decode([Recipe].self, from: data) {
          DispatchQueue.main.async {
            self.recipes = decodedResponse
            print(decodedResponse)
          }
          return
        }
      }
      print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
    }.resume()
  }
  
}

struct SearchResults_Previews: PreviewProvider {
    static var previews: some View {
      SearchResults(ingredients: .constant(["tomato"]))
    }
}
