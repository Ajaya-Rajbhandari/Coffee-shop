import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coffee_shop/screens/home_screen.dart'; // Updated import
import 'package:coffee_shop/screens/registration_screen.dart'; // Updated import
import 'package:coffee_shop/screens/login_screen.dart'; // Updated import
import 'package:coffee_shop/screens/shopping_list.dart'; // Updated import
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Successfully signed in
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              shoppingList: ShoppingList(),
              userName: googleUser.displayName ?? "User", // Pass userName
              userAddress: "", // Pass userAddress if applicable
              profilePicturePath:
                  googleUser.photoUrl ?? "", // Pass profilePicturePath
              addFavorite: (item) {
                print('Added to favorites: ${item['name']}');
              },
            ),
          ),
        );
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 50, bottom: 40),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            image: DecorationImage(
              image: AssetImage("images/bg.png"),
              fit: BoxFit.cover,
              opacity: 0.6,
            )),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 250),
              Text("Coffee Shop",
                  style: GoogleFonts.pacifico(
                    fontSize: 50,
                    color: Colors.white,
                  )),
              SizedBox(height: 20),
              Text("Feeling Low? Take a Sip of Coffee",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  )),
              SizedBox(height: 200),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Sign up for free",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    _handleGoogleSignIn(context);
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/google_icon.png',
                          height: 24.0,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Continue with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
