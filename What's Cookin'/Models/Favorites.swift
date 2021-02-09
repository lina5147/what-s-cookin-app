//
//  Favorites.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/8/21.
//

import Foundation
import Combine

class Favorites : ObservableObject {
  @Published var favoriteRecipes = [RecipeInfo]()
}

