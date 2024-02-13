# MealHub

## Description
The MealHub IOS mobile app:  
The app allows users to schedule recipes for themselves to cook from a provided array of meal recipes, recommended based on the user's dietary preferences and current ingredients owned in their kitchen. 

Utilizing the CoreData and Userdefaults frameworks the application keeps track of the user's dietary preferences, restrictions, intolerances, favorited recipes, kitchen ingredients, and grocery list items while allowing users to schedule meals on their calendar to create a dietary regimen.

The meals provided are pulled from the Spoonacular Food and Recipe API with diversified results to cater to the user's tastes and needs. The query is dynamically built using the user's preferences set throughout the app. 
<br>
> **These preferences include:**
> - Meal Prep Time Preference
> - Desired Ingredients to Include
> - Desired Ingredients to Exclude
> - Dietary Needs
> - Cuisine Type
> - Food Intolerances

Using asynchronous URLSession fetch requests the application pulls data from the Food and Recipe API to fill the recipe displays. When pinging endpoints with a given set of parameters, the return set of recipes is always in the same order, so an offset parameter is randomized to randomize results. If there are not enough recipes to fill the display the first 6 of the non-offset list are chosen. If there are still not enough to fill the display a random set of recipes matching dietary restrictions in the meal category are selected. The application effectively manages concurrent fetch requests to maintain a smooth user experience and continuously updates results.


Following a professional UI/UX designer's specifications MealHub uses the SwiftUI framework to create an intuitive and user-friendly design, ensuring a seamless and enjoyable experience for users of all levels. 


## Available on App Store for IPhone
https://apps.apple.com/us/app/mealhub/id6477729202


## Screenshots
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/eca2b6bf-854b-4fec-821d-af36c6b7dd4e" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/ce742123-1d3b-4636-8108-204a6156b1e8" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/eb1a9210-9c47-445c-a6b5-ee240531b7c3" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/9a8e47f6-b554-4aa8-830f-811ecb2b64d3" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/f8f8c1d4-ef5b-4a97-9ff3-55cdf26663ad)" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/0dc7bd35-19af-4add-95c5-c3e35534e7bf)" width="300"/>
<img src="https://github.com/Dhowes24/MealHub/assets/33637595/2639b711-a107-425b-8715-b77400f6cd1a)" width="300"/>

