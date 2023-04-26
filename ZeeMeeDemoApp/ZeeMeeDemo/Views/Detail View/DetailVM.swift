//
//  DetailVM.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import Foundation
import UIKit

@MainActor
class DetailVM: ObservableObject {
    let drinkId: String
    private let service: NetworkClient
    
    @Published var drinkDetails: DrinksDetailsModel?
    
    // Leaving commented code in for Live Preview
    
//    let drink = DrinksDetailsModel(id: "11118", strDrink: "Blue Margarita", strDrinkThumb: "https://www.thecocktaildb.com/images/media/drink/bry4qh1582751040.jpg", strCategory: "Ordinary Drink", strInstructions: "Rub rim of cocktail glass with lime juice. Dip rim in coarse salt. Shake tequila, blue curacao, and lime juice with ice, strain into the salt-rimmed glass, and serve.", strGlass: "Cocktail glass", strIngredient1: "Tequila", strIngredient2: "Blue Curacao", strIngredient3: "Lime juice", strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strMeasure1: "1 1/2 oz ", strMeasure2: "1 oz ", strMeasure3: "1 oz ", strMeasure4: "Coarse ", strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil)
    
    var cocktailIngredients: [(measure: String, ingredient: String)] = []
    
    init(drinkId: String, service: NetworkClient = NetworkService()) {
        self.drinkId = drinkId
        self.service = service
       
    // Live Preview Code
//        drinkDetails = drink
//        fetchCocktailIngredients()
        
    }
    
    func fetchCocktailDetails() async throws {
        let endpoint = Endpoint(
            path: EndPointPaths.details, queryItems: [URLQueryItem(name: "i", value: drinkId)]
        )
        do {
            let result: DrinkLookupResult = try await service.loadData(from: endpoint)
            drinkDetails = result.drinks?.first
        } catch {
            print(error)
        }
        
        fetchCocktailIngredients()
    }
    
    private func fetchCocktailIngredients() {
        guard let drinkDetails = drinkDetails?.asDictionary() else { return }
        
        var ingredients: [(measure: String, ingredient: String)] = []
        
        for (index, _) in drinkDetails.keys.enumerated() {
            if let ingredient = drinkDetails["strIngredient\(index + 1)"] as? String,
               let measure = drinkDetails["strMeasure\(index + 1)"] as? String {
                
                ingredients.append((measure: measure, ingredient: ingredient))
            }
        }
        
        cocktailIngredients = ingredients
    }
}

