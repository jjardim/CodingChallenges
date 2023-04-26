//
//  DrinkCellView.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import SwiftUI

struct DrinkCellView: View {
    
    var drink: SearchResultsDrinksModel
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 68, height: 68)
            .background(Color.gray)
            .clipShape(Circle())
            
            VStack(spacing: 5){
                Text(drink.strDrink)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(drink.strCategory.uppercased())
                    .font(.system(size: 11).bold())
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(drink.strInstructions)
                    .font(.system(size: 14))
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}


struct DrinkCellView_Previews: PreviewProvider {
    
    static let viewModel = SearchResultsDrinksModel(id: "1001", strDrink: "Margarita", strDrinkThumb: "https://www.thecocktaildb.com/images/media/drink/5noda61589575158.jpg", strCategory: "Ordinary Drink", strInstructions: "Rub the rim of the glass with the lime slice to make the salt stick to it. Take care to moisten only the outer rim and sprinkle the salt on it. The salt should present to the lips of the imbiber and never mix into the cocktail. Shake the other ingredients with ice, then carefully pour into the glass.")
    
    static var previews: some View {
        DrinkCellView(drink: viewModel)
        DrinkCellView(drink: viewModel)
            .preferredColorScheme(.dark)
    }
}
