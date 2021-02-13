//
//  Recipe.swift
//  What's Cookin'
//
//  Created by Lina Do on 2/13/21.
//

import Foundation
import SwiftUI

struct Recipe: Codable, Identifiable, Hashable {
  var id: Int
  var title: String
  var image: String
  var additionalIngredients: [String]
}
