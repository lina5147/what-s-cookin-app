//
//  Recipe.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/8/21.
//

import Foundation
import SwiftUI

struct RecipeInfo : Hashable {
  var id: Int
  var title: String
  var image: String
  var ingredients: [String]
  var instructions: [String]
}
