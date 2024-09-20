//
//  MealDetailViewModel.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/18/24.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    @Published var meal: Meal? = nil
    
    func fetchMeal(idMeal: String) async {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(idMeal)"
        guard let url = URL(string: urlString) else {
            print("Error: invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(MealResponse.self, from: data)
            
            await MainActor.run {
                if mealResponse.meals.count != 1 {
                    print("Error: invalid detail response")
                    return
                }
                self.meal = mealResponse.meals[0]
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
