import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleItemScreen extends StatefulWidget {
  final String itemName;
  final String itemImage;
  final String itemPrice;
  final Function(String, String, double) addToCart;
  final Function(String) notifyAddToCart; // Add notification function
  final Function(Map<String, dynamic>) addFavorite; // Add favorite function

  SingleItemScreen({
    Key? key,
    required this.itemName,
    required this.itemImage,
    required this.itemPrice,
    required this.addToCart,
    required this.notifyAddToCart, // Accept notification function
    required this.addFavorite, // Accept add favorite function
  }) : super(key: key);

  @override
  _SingleItemScreenState createState() => _SingleItemScreenState();
}

class _SingleItemScreenState extends State<SingleItemScreen> {
  int quantity = 1; // Initialize quantity
  bool isFavorite = false; // Track favorite state

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite; // Toggle favorite state
      if (isFavorite) {
        widget.addFavorite({
          'name': widget.itemName,
          'image': widget.itemImage,
          'price': double.parse(widget.itemPrice),
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    widget.itemImage,
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BEST COFFEE",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            letterSpacing: 3),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.itemName,
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: decrement,
                                    child: Icon(
                                      CupertinoIcons.minus,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    "$quantity",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  GestureDetector(
                                    onTap: increment,
                                    child: Icon(
                                      CupertinoIcons.plus,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "\$${widget.itemPrice}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Coffee is a major source of antioxidants in the diet. It has many health benefits.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Volume: ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "30 ml",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                widget.addToCart(
                                    widget.itemName,
                                    widget.itemImage,
                                    double.parse(widget.itemPrice) *
                                        quantity); // Use current quantity
                                widget.notifyAddToCart(
                                    "Added '${widget.itemName}' to cart."); // Notify user for add to cart
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 50, 54, 56),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: toggleFavorite,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color(0xFFE57734),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
