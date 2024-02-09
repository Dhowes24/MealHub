# MealHub
### Description
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
