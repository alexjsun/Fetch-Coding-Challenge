//
//  MealListViewModel.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import Foundation
import SwiftUICore

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var showingAlert = false
    
    func fetchMeals() async {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            await MainActor.run {
                showingAlert = true
            }
            print("Error: invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealListResponse = try decoder.decode(MealResponse.self, from: data)
            
            await MainActor.run {
                showingAlert = false
                meals = mealListResponse.meals
            }
        } catch {
            await MainActor.run {
                showingAlert = true
            }
            print("Error: \(error.localizedDescription)")
        }
    }
}
