//
//  SearchModel.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation

struct SearchResultsDrinksModel: Identifiable, Decodable, Hashable {
  let id: String
  let strDrink: String
  let strDrinkThumb: String
  let strCategory: String
  let strInstructions: String
  
  enum CodingKeys: String, CodingKey {
    case id = "idDrink"
    case strDrink
    case strDrinkThumb
    case strCategory
    case strInstructions
  } 
}
