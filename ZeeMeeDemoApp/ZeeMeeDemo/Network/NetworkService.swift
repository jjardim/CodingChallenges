//
//  NetworkService.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation

struct NetworkService: NetworkClient {
  private let session: URLSession
  
  init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  func loadData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
    let url = endpoint.url
    let (data, response) = try await session.data(from: url)
    
    guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
      throw ServerError.notOK
    }
    
    do {
      let result = try JSONDecoder().decode(T.self, from: data)
      return result
    } catch {
      throw ClientErrors.dataParsingFailed
    }
  }
}
