//
//  MealDetailView.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import SwiftUI

struct MealDetailView: View {
    @ObservedObject var detailViewModel = MealDetailViewModel()
    @State var errorDismissed: Bool = false
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
                    if let ingredients = meal.ingredients {
                        ForEach(Array(ingredients.keys), id: \.self) { ingredient in
                            HStack {
                                Text(ingredient)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(ingredients[ingredient] ?? "Unknown amount")
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                } else {
                    errorDismissed ?
                    AnyView(Text("Sorry! Couldn't get meal details")) :
                    AnyView(ProgressView())
                }
            }
            .padding()
            .navigationTitle("Meal Details")
            .task {
                await detailViewModel.fetchMeal(idMeal: idMeal)
            }
            .alert(isPresented: $detailViewModel.showingAlert) {
                Alert(title: Text("Sorry!"),
                      message: Text("We couldn't get a list of meals"),
                      primaryButton: .default(Text("Retry")) {
                          errorDismissed = false
                          Task {
                              await detailViewModel.fetchMeal(idMeal: idMeal)
                          }
                      },
                      secondaryButton: .cancel(Text("Dismiss")) {
                          errorDismissed = true
                })
            }
        }
    }
}

#Preview {
    MealDetailView(idMeal: "52767")
}

