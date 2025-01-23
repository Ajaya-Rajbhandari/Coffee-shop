import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favoriteItems = [];

  void addFavorite(Map<String, dynamic> item) {
    print('Attempting to add favorite: ${item['name']}'); // Debugging statement
    if (!favoriteItems.any((element) => element['name'] == item['name'])) {
      setState(() {
        favoriteItems.add(item);
      });
      // Show notification
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['name']} added to favorites!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('${item['name']} is already in favorites.'); // Debugging statement
    }
  }

  void removeFavorite(int index) {
    setState(() {
      favoriteItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Items'),
        backgroundColor: Color.fromARGB(255, 254, 254, 255),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF212325),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              spreadRadius: 1,
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your favorite items:',
                style: TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Image.asset(item['image']),
                      title: Text(
                        item['name'],
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        '\$${item['price'].toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          removeFavorite(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            if (favoriteItems.isEmpty)
              Center(
                child: Text(
                  'No favorite items yet!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
