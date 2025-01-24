import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_shop/screens/shopping_list.dart'; // Updated import
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart'; // Ensure HomeScreen is imported

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isEmailValid = false;

  void _register() async {
    if (_isEmailValid) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        User? user = _auth.currentUser;
        if (user != null) {
          // User is registered, navigate to HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      shoppingList: ShoppingList(),
                      userName: user.displayName ?? "User", // Pass userName
                      userAddress: "", // Pass userAddress if applicable
                      profilePicturePath:
                          user.photoURL ?? "", // Pass profilePicturePath
                      addFavorite: (item) {
                        print('Added to favorites: ${item['name']}');
                      },
                    )),
          );
        } else {
          // User is not registered, navigate to RegistrationScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegistrationScreen()),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Registration failed")),
        );
      }
    }
  }

  Future<void> _registerWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final UserCredential userCredential = await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ),
        );
        // Navigate to home screen after successful registration
        Navigator.pushReplacement(
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
                  )),
        );
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
    }
  }

  void _validateEmail(String email) {
    setState(() {
      _isEmailValid = email.isNotEmpty && email.contains('@');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage("images/Warm-Cappuccino.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("What's your email?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                  onChanged: _validateEmail,
                ),
                SizedBox(height: 10),
                if (_isEmailValid) ...[
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Text("Sign Up"),
                  ),
                ],
                SizedBox(height: 10),
                if (!_isEmailValid) ...[
                  ElevatedButton(
                    onPressed: _registerWithGoogle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/google_icon.png',
                          height: 24.0,
                        ),
                        SizedBox(width: 10),
                        Text("Register with Google"),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
