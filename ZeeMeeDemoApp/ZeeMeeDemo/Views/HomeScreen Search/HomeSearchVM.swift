//
//  HomeSearchVM.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation

@MainActor
class HomeSearchVM: ObservableObject {
    
    private let service: NetworkClient
    
    @Published private(set) var searchResults: [SearchResultsDrinksModel] = []
    
        
    init(service: NetworkClient = NetworkService()) {
        self.service = service
    }
    
    func clearSearchResults() {
        searchResults.removeAll()
    }
    
    var timer: Timer?
    
    func search(term: String) {
        timer?.invalidate()
        // debounce calling the search API by 1.6 seconds
        timer = Timer.scheduledTimer(withTimeInterval: AppBehavior.searchTimeout, repeats: false) { timer in
            Task {
                await self.callAPI(searchTerm: term)
            }
        }
    }
    
    func explicitSearch(term: String) {
        timer?.invalidate()
        Task {
            await self.callAPI(searchTerm: term)
        }
    }
    
    private func callAPI(searchTerm: String) async {
        
        if searchTerm.isEmpty { return }
        
        clearSearchResults()
        
        let endpoint = Endpoint(
            path: EndPointPaths.search,
            queryItems: [URLQueryItem(name: "s", value: searchTerm)]
        )
        
        do {
            let searchResults: DrinkSearchResults = try await service.loadData(from: endpoint)
            self.searchResults = searchResults.drinks ?? []
        } catch {
            print(error)
        }
    }
}
