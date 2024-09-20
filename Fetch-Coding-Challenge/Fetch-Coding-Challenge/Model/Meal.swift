//
//  Meal.swift
//  Fetch-Coding-Challenge
//
//  Created by Alex Sun on 9/17/24.
//

struct Meal: Identifiable, Decodable {
    var id: String {idMeal}
    let idMeal: String
    let title: String
    let thumbnail: String
    let instructions: String?
    let ingredients: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.title = try container.decode(String.self, forKey: .strMeal)
        self.thumbnail = try container.decode(String.self, forKey: .strMealThumb)
        
        self.instructions = try? container.decode(String.self, forKey: .strInstructions)
        var ingredients = [String: String]()
        for i in 1...20 {
            guard let ingredient = CodingKeys(stringValue: "strIngredient\(i)"),
                  let measure = CodingKeys(stringValue: "strMeasure\(i)") else {
                continue
            }

            if let ingredient = try? container.decode(String.self, forKey: ingredient), !ingredient.isEmpty,
               let measure = try? container.decode(String.self, forKey: measure), !measure.isEmpty {
                ingredients[ingredient] = measure
            }
        }
        self.ingredients = ingredients
    }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}
