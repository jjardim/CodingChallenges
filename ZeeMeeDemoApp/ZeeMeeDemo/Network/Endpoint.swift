//
//  Endpoint.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation

struct EndPointPaths {
  static let search = "api/json/v1/1/search.php"
  static let details = "api/json/v1/1/lookup.php"
}

struct Endpoint {
  var path: String
  var queryItems: [URLQueryItem] = []
}

extension Endpoint {
  var url: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "www.thecocktaildb.com"
    components.path = "/" + path
    
    if !queryItems.isEmpty {
      components.queryItems = queryItems
    }
    
    return components.url!
  }
}
