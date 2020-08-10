# ShoppingCart

## Introduction: 
ShoppingCartApp  is a  test project app which consumes a RESTful API to demonstrate a shopping cart application. 

## Functionality
List of products
Add to cart
Remove from cart
Add to wishlist
Remove from wish list
Offline storage

## Architecture
In this project I have demonstrated my knowldege of VIPER pattern which is used to apply the concepts of SOLID  principles. We can test each component separately using mocks and this improves the overall testability of code and also makes bug fixing easier in the long run. Unit tests have been added to cover ProductList scene as well ShoppingCartService layer. 


## Storage
Realm is used for persisting  data in the app to view wishlist: Reason behind choosing realm over coredata  in this case is the ease of setting up the store without having to deal with any boilerplate code and also the problem in hand has non relational objects. 
I have taken a protocol based approach -  creating a FACADE pattern which can even let us replace the underlying persistent framework to core data in the future without having to change any other classes that depenend on it.

### Todo:
Moving products from wishlist to cart
Reachability 


## Buiild Notes
Build with Xcode: Version 11.3.1 
Target Device: iOS, iPad : iOS: 13+
If you have the latest version of xcode: please use realmswift 5.2.0 from https://realm.io/docs/swift/latest/

