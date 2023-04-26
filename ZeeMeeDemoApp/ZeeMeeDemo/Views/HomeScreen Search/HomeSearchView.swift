//
//  ContentView.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import SwiftUI

struct HomeSearchView: View {
    
    @State private var searchTerm = ""
    @StateObject private var viewModel = HomeSearchVM()
    
    @State private var selectedDrink: SearchResultsDrinksModel? = nil
    
    @Environment(\.isSearching) private var isSearching: Bool
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationView {
            VStack {
                listStack
                    .searchable(text: $searchTerm)
                    .onSubmit(of: .search) {
                        Task {
                            viewModel.explicitSearch(term: searchTerm)
                        }
                    }
                    .onChange(of: searchTerm) { value in
                        if searchTerm.isEmpty && !isSearching {
                            viewModel.clearSearchResults()
                        }
                        
                        Task {
                            viewModel.search(term: searchTerm)
                        }
                    }
                    .navigationTitle("Search")
                    .accessibility(identifier: "home.searchField")

            }
            .sheet(item: $selectedDrink) { drink in
                DetailView(viewModel: DetailVM(drinkId: drink.id))
            }
        }
    }
    
    
    
    var listStack: some View {
        List {
            ForEach(Array(viewModel.searchResults.enumerated()), id: \.element.self) { index, drink in
                DrinkCellView(drink: drink)
                    .onTapGesture {
                        self.selectedDrink = drink
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView()
        HomeSearchView()
            .preferredColorScheme(.dark)
    }
}
