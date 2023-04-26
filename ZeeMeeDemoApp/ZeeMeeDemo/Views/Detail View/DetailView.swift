//
//  DetailView.swift
//  ZeeMeeDemo
//
//  Created by Jason Jardim on 4/3/23.
//

import SwiftUI


struct DetailView: View {
    
    @StateObject var viewModel: DetailVM
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        if viewModel.drinkDetails != nil {
            
            VStack(spacing: 0) {
                
                toolbarView
                
                ScrollView {
                    titleBarView
                    drinkImageView
                    instructionsView
                    ingredientsView
                    glassNeededView
                }
                shareButton
            }
            
            // There is 2 different ways we can scroll the screen.
            // if the "shareButton" is moved in the Scrollview it will
            // scroll with the rest of the screen.
            // Also uncomment out the following line
            
//            .edgesIgnoringSafeArea(.bottom)
                
        } else {
            ProgressView()
                .onAppear{
                    Task {
                        try await viewModel.fetchCocktailDetails()
                    }
                }
        }
    }
    
    // MARK: Views
    
    var toolbarView: some View {
        
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image("DismissIcon")
                        .padding()
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image("ShareIcon")
                        .padding()
                }
            }
        }
    }
    
    var titleBarView: some View {
        Text("\(viewModel.drinkDetails!.strDrink)")
            .font(.largeTitle).bold()
            .padding([.leading, .bottom])
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var drinkImageView: some View {
        
        AsyncImage(url: URL(string: viewModel.drinkDetails!.strDrinkThumb)) { image in

            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 225)
                .clipped()
                .overlay(
                    Text("ORDINARY DRINK")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.green)
                        )
                        .padding(.leading, 30)
                        .padding(.bottom, 30),
                    alignment: .bottomLeading
                )

        } placeholder: {
            ProgressView()
        }
    }
    
    var instructionsView: some View {
        
        VStack(spacing: 20) {
            Text("INSTRUCTIONS")
                .font(.system(size: 14).bold())
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            Text(viewModel.drinkDetails!.strInstructions)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
        .padding(.top)
    }
    
    var ingredientsView: some View {
        
        VStack(spacing: 10) {
            Text("\(viewModel.cocktailIngredients.count) INGREDIENTS")
                .font(.system(size: 14).bold())
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            ForEach(viewModel.cocktailIngredients.indices, id: \.self) { index in
                Group {
                    Text(viewModel.cocktailIngredients[index].measure)
                        .font(.system(size: 14, weight: .bold))
                    +
                    Text(viewModel.cocktailIngredients[index].ingredient)
                        .font(.system(size: 14))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            }
        }
        .padding(.top)
    }
    
    var glassNeededView: some View {
        
        VStack(spacing: 10) {
            Text("GLASS NEEDED")
                .font(.system(size: 14).bold())
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            Text(viewModel.drinkDetails!.strGlass)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
        }
        .padding(.top)
    }
    
    var shareButton: some View {
        Button(action: {}) {
            HStack {
                Image("ShareIcon")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Share")
            }
            .frame(width: 327, height: 64)
            
        }
        .foregroundColor(.white)
        .background(.blue)
        .cornerRadius(AppBehavior.buttonCornerRadius)
        .font(.system(size: 20).bold())
        .padding(.top)
    }
}

struct DetailView_Previews: PreviewProvider {
  
  static let viewModel = DetailVM(drinkId: "1001")

  static var previews: some View {
    DetailView(viewModel: viewModel)
    DetailView(viewModel: viewModel)
      .preferredColorScheme(.dark)

  }
}
