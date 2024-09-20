//
//  MealListViewModel.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import Foundation

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    
    func fetchMeals() async {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            print("Error: invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealListResponse = try decoder.decode(MealResponse.self, from: data)
            
            await MainActor.run {
                self.meals = mealListResponse.meals
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
