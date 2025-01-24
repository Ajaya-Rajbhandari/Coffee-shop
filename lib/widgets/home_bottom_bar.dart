import 'package:flutter/material.dart';
import 'package:coffee_shop/screens/favorite_screen.dart'; // Updated import
import 'package:coffee_shop/screens/profile_screen.dart'; // Updated import
import 'package:coffee_shop/screens/shopping_list.dart'; // Updated import
import 'package:coffee_shop/screens/welcome_screen.dart'; // Updated import

class HomeBottomBar extends StatelessWidget {
  final ShoppingList shoppingList; // Add ShoppingList reference
  final String userName; // Add userName reference
  final String userAddress; // Add userAddress reference
  final String profilePicturePath; // Add profilePicturePath reference

  HomeBottomBar({
    required this.shoppingList,
    required this.userName,
    required this.userAddress,
    required this.profilePicturePath,
  }); // Constructor to accept ShoppingList and user details

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            },
            child: Icon(
              Icons.home,
              color: Color(0xFFEE57734),
              size: 35,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteScreen()));
            },
            child: Icon(
              Icons.favorite_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Scaffold(
                          body: ShoppingListWidget(
                              shoppingList:
                                  shoppingList)))); // Wrap in Scaffold
            },
            child: Icon(
              Icons.shopping_bag_sharp,
              color: Colors.white,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userName: userName, // Pass userName
                    userAddress: userAddress, // Pass userAddress
                    profilePicturePath:
                        profilePicturePath, // Pass profilePicturePath
                  ),
                ),
              );
            },
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}
