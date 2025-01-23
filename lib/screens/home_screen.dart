import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/notification_screen.dart';
import 'package:flutter_application_1/widgets/home_bottom_bar.dart';
import 'package:flutter_application_1/widgets/items_widget.dart';
import 'package:flutter_application_1/screens/shopping_list.dart'; // Import ShoppingList
// Import FavoriteScreen

class HomeScreen extends StatefulWidget {
  final ShoppingList shoppingList; // Add ShoppingList reference
  final Function(Map<String, dynamic>) addFavorite; // Add addFavorite reference

  HomeScreen(
      {required this.shoppingList,
      required this.addFavorite}); // Constructor to accept ShoppingList and addFavorite

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> cartItems = []; // List to hold cart items

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void addToCart(String itemName, String itemImage, double itemPrice) {
    setState(() {
      // Check if item already exists in the cart and log the action
      print('Attempting to add item: $itemName');

      final existingItem = cartItems.firstWhere(
        (cartItem) => cartItem['name'] == itemName,
        orElse: () => {
          'name': itemName,
          'image': itemImage,
          'quantity': 0,
          'price': itemPrice
        },
      );

      if (existingItem['quantity'] > 0) {
        existingItem['quantity']++; // Increment quantity if item exists
      } else {
        print('Adding new item: $itemName');

        cartItems.add({
          'name': itemName,
          'image': itemImage,
          'quantity': 1,
          'price': itemPrice
        }); // Add new item
      }

      // Update the shopping list
      widget.shoppingList.addItem(
          itemName, itemImage, itemPrice); // Call addItem from ShoppingList
    });
    print('Added to cart: $itemName, $itemImage, $itemPrice');
  }

  void notifyAddToCart(String itemName) {
    // Show notification
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$itemName added to cart!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void addFavorite(Map<String, dynamic> item) {
    // Call the addFavorite function passed from WelcomeScreen
    widget.addFavorite(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.sort_rounded,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white.withOpacity(0.5),
                        size: 35,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "It's a Great Day for Coffee",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 50, 54, 56),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Find your coffee",
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white.withOpacity(0.5),
                      )),
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: Color(0xFFE57734),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Color(0xFFEE57734),
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 15),
                ),
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                tabs: [
                  Tab(text: "Hot Coffee"),
                  Tab(text: "Cold Coffee"),
                  Tab(text: "Cappuccino"),
                  Tab(text: "Americano"),
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: [
                  ItemsWidget(
                      addToCart: addToCart,
                      notifyAddToCart: notifyAddToCart,
                      addFavorite: addFavorite), // Pass addFavorite
                  ItemsWidget(
                      addToCart: addToCart,
                      notifyAddToCart: notifyAddToCart,
                      addFavorite: addFavorite), // Pass addFavorite
                  ItemsWidget(
                      addToCart: addToCart,
                      notifyAddToCart: notifyAddToCart,
                      addFavorite: addFavorite), // Pass addFavorite
                  ItemsWidget(
                      addToCart: addToCart,
                      notifyAddToCart: notifyAddToCart,
                      addFavorite: addFavorite), // Pass addFavorite
                ][_tabController.index],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: HomeBottomBar(
          shoppingList: widget.shoppingList), // Pass ShoppingList instance
    );
  }
}
