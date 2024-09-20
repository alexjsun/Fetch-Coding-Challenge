# Fetch-Coding-Challenge

## Overview

This is a SwiftUI-based native iOS application that allows users to browse recipes using the [MealDB API](https://themealdb.com/api.php), utilizing two of its endpoints:

- https://themealdb.com/api/json/v1/1/filter.php?c=Dessert for fetching the list of meals in the Dessert category.
- https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID for fetching the meal details by its ID.

## Getting started

1. Clone this repository
`git clone https://github.com/alexjsun/Fetch-Coding-Challenge.git`

2. Open project in Xcode
`open Fetch-Coding-Challenge/Fetch-Coding-Challenge/Fetch-Coding-Challenge.xcodeproj/`

## Design

This project follows an [MVVM](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93viewmodel) architecture for organization and separation of functionality from the View.

### Models

- **Meal**: represents the individual Meal data returned by the two MealDB APIs, with some data cleaning (notably turning `strIngredients` and `strMeasurement` mappings into a Dictionary)

- **MealResponse**: represents the raw response returned based on the two MealDB APIs, since the API returns an array of meals in both cases

### View Models

- **MealListViewModel**: makes request for list of meals and provides the **MealListView** with data to display. 

- **MealDetailViewModel**: makes request for the details of a specific meal and provides the **MealDetailView** with data to display. 

Although these ViewModels have similar functionality, I decided to keep them separate for scalability. If we need to extend and maintain distinct functionalities for this app, I would like to keep ViewModels isolated for scalability.

### Views

- **MealListView**: displays the list of meals as a title and thumbnail, with a clickable link to the **MealDetailView**

- **MealDetailView**: displays the details of the selected meal. 

Both of these views also present alerts in the case of errors, such as API failures. Note: they will simply state a generic error, but we will print the actual error to the console. I chose not to expose this as hypothetical customers do not have control over these API calls and providing an actual error will confuse them (and they also can't really do anything to solve it). I decided this would be a better UX for customers.
