import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:coffee_shop/screens/home_screen.dart'; // Updated import
import 'package:coffee_shop/screens/shopping_list.dart'; // Updated import

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = _auth.currentUser;

      // Create an instance of ShoppingList
      ShoppingList shoppingList = ShoppingList();

      // Navigate to home screen on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            shoppingList: shoppingList, // Pass the ShoppingList instance
            userName: user?.displayName ?? "User", // Pass userName
            userAddress: "", // Pass userAddress if applicable
            profilePicturePath: user?.photoURL ?? "", // Pass profilePicturePath
            addFavorite: (item) {
              // Define how to add to favorites
            },
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      // Handle error and show a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      // Create an instance of ShoppingList
      ShoppingList shoppingList = ShoppingList();

      // Navigate to home screen on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            shoppingList: shoppingList,
            userName: user?.displayName ?? "User",
            userAddress: "",
            profilePicturePath: user?.photoURL ?? "",
            addFavorite: (item) {
              // Define how to add to favorites
            },
          ),
        ),
      );
    } catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              style: TextStyle(color: Colors.black),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text("Continue with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
