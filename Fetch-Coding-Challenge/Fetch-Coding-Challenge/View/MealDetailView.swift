//
//  MealDetailView.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var detailViewModel = MealDetailViewModel()
    var idMeal: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let meal = detailViewModel.meal {
                    HStack {
                        Text(meal.title)
                            .font(.title)
                            .bold()
                        Spacer()
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Rectangle())
                        Spacer()
                    }
                    
                    Text("Instructions")
                        .font(.headline)
                    Text(meal.instructions ?? "No instructions available")
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(Array(meal.ingredients!.keys), id: \.self) { ingredient in
                        if let ingredients = meal.ingredients {
                            HStack {
                                Text(ingredient)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(ingredients[ingredient] ?? "Unknown amount")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .padding()
            .navigationTitle("Meal Details")
            .task {
                await detailViewModel.fetchMeal(idMeal: idMeal)
            }
        }
    }
}

#Preview {
    MealDetailView(idMeal: "52767")
}

