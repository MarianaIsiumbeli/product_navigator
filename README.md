# product_navigator

Product Navigator Application

*****
Purpose
*****
The Product Navigator Application is designed to enhance the shopping experience by providing users with product information and price comparisons across various stores. It allows users to search for products based on specific criteria, view detailed information and manage updated shopping lists efficiently. Initially, the app utilize a simulated database, with the potential to integrate real APIs later for live data retrieval and updates.


*****
Functionality
*****
2.1. User Authentication
Home Page: Features animations and provides easy access to settings, registration, and login options.
Registration and Login Page: Users can register and log in securely using Firebase Authentication, ensuring individualized access to personalized shopping lists and preferences.
User Session: After logging in, users gain access to their personalized lists and preferences. The user account page includes a navigation menu that leads to the search page or lists page.

2.2. Product Search
Search Criteria:
Name: Search for products by their name (e.g., “iPhone”). This is a required field.
Search Results: Displays a list of products that match the search criteria, showing product names, producers, models, descriptions and prices from different stores.

2.3. Product Details
Item Information: Provides detailed descriptions, specifications, user ratings and reviews from the simulated database. Currently, images are not included.
Stores: Displays stores where the product is available.
Prices: Shows product prices at each store.
Actions: Allows users to either add the product to a shopping list or cancel and return to search results.

2.4. List Management
Create New List: Users can create a new shopping list by providing a custom name. 
View Existing Lists: Users can view and manage their saved lists.
Add Item to List: Users can add products to existing lists. Available lists are displayed for easy selection.
List Details: Displays a list of all products in the selected list, including names, quantities and prices. Users can delete or add a product and the total price will update automatically. The list also displays the total sum of products for the selected list.
List Management: Users can delete lists. Deleting a list prompts a confirmation.

2.5. Settings Page
Dark Mode: Provides an option to toggle between light and dark modes for improved user experience based on preferences.

2.6. User Experience
Animations:
Homepage Animation: Engages users with dynamic animations on the home page.
Slide Transitions: Smooth transitions between pages to improve the overall user experience.
Gestures: Implemented swipe gestures to enhance navigation and interaction within the app.

Responsiveness:
The homepage and search page (landing page) are responsive in both portrait and landscape modes for tablets.


*****
Technologies Used
*****
Flutter: Framework for building the cross-platform mobile app
*
Firebase Authentication: Secure authentication for users
*
Firebase Firestore: Cloud database for storing and managing products data
*
Provider: State management for handling user authentication and search state
*
SharedPreferences: For persisting theme and list updates
*
Flutter Animations: For smooth transitions and animations across the app

*****
Demo for the project can be viewed here: https://drive.google.com/file/d/1JR_tiuBb_7WQLw4OuQem7yumB9DcYv2g/view?usp=drive_link

Responsiveness for the tablet screen can be viewed here: https://drive.google.com/file/d/1uyQYIY_bp4f8TDAzRBRoczRqACo1nua5/view?usp=drive_link
*****