//
//  MealListView.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import SwiftUI

struct MealListView: View {
    @ObservedObject var listViewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            List(listViewModel.meals.sorted { $0.title.lowercased() < $1.title.lowercased() }) { meal in
                NavigationLink(destination: MealDetailView(idMeal: meal.idMeal)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Capsule())
                        Text(meal.title)
                    }
                }
            }
            .navigationTitle("Meals")
            .task {
                await listViewModel.fetchMeals()
            }
            .alert(isPresented: $listViewModel.showingAlert) {
                Alert(title: Text("Sorry!"),
                      message: Text("We couldn't get a list of meals"),
                      primaryButton: .default(Text("Retry")) {
                          Task {
                              await listViewModel.fetchMeals()
                          }
                      },
                      secondaryButton: .cancel(Text("Dismiss")))
            }
        }
    }
}

#Preview {
    MealListView()
}
