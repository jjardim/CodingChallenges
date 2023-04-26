//
//  NetworkClient.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation

protocol NetworkClient {
  func loadData<T: Decodable>(from endpoint: Endpoint) async throws -> T
}
