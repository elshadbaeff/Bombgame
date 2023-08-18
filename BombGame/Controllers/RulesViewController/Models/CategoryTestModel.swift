//
//  CategoryTestModel.swift
//  BombGame
//
//  Created by Kirill Taraturin on 09.08.2023.
//

import Foundation

struct CategoryRules {
  var image: String
  var name: String

  static func getGategories() -> [CategoryRules] {
    var allCategories: [CategoryRules] = []
    for (key, value) in categories {
      allCategories.append(CategoryRules(image: value, name: key))
    }
    return allCategories
  }
}

let categories = [
  "Природа" : "flower",
  "Искусcтво и кино": "cinema",
  "Разное" : "planet",
  "Cпорт и хобби": "sports"
]
