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
                            .padding()
                        AsyncImage(url: URL(string: meal.thumbnail))
                            .frame(width: 100, height: 100)
                            .clipShape(Rectangle())
                    }.padding(.bottom)
                    
                    Text("Instructions")
                        .font(.headline)
                    Text(meal.instructions ?? "No instructions available")
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(Array(meal.ingredients!.keys), id: \.self) { ingredient in
                        if let ingredients = meal.ingredients {
                            Text("\(ingredient) – \(ingredients[ingredient] ?? "Unknown amount")")
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

