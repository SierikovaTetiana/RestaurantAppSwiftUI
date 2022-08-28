# 🍕RestaurantApp on SwiftUI
 Restaurant food order app on SwiftUI + MVVM. Swift 5. Xcode 13.4. iOS 15. 

## 📷 Screenshots

![MockupDeGustoSwiftUI](https://user-images.githubusercontent.com/75028505/187045279-7822d398-a335-4cd2-8f6e-be1c36002bcc.jpg)

## 💻 Technologies:
- Firebase Authentication
- Firebase Realtime Database
- Firebase Storage
- Firestore Database
- Facebook Authentication
- MapKit
- Core Data

## 🔖 Features: 
- Restaurant menu:
  -  show top discount section with infinite scroll by timer 
  -  with show/hide dishes in categories
  -  dish can be added to favorite list (appears when dish added and dissappears when all dishes removed from list)
  -  dish can be added to cart
- Map:
  -  display map with pin
- Account profile:
  -  register user by email-password or Facebook
  -  user can upload photo to profile
  -  user can set and change profile information: name, birth date, phone number, password, email (integrated with Firestore Database)
  - Cart:
  -  user can change amount of dishes or remove all of it
- Order process:
  -  if user is registered in app all information fill fields
  -  user can choose take away or delivery
  -  if user selects delivery, address field is displayed (required for order)
  -  user can select time for delivery or ready to take away
  -  order button sends information about order to Database
  -  simple app written in Python sends email with order

Images and menu text from [DeGusto](https://degustotrattoria.kh.ua/)
