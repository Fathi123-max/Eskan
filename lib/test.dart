import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define primary and accent colors
    final primaryColor = Colors.teal;
    final accentColor = Colors.orange;

    return MaterialApp(
      title: 'Real Estate App',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        secondaryHeaderColor: accentColor,
        fontFamily: 'Montserrat',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real Estate App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for properties...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
              ),
            ),
          ),
          // Featured properties section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Featured Properties',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PropertyCard(
                        image: 'assets/images/property1.jpg',
                        title: 'Beautiful 2BR Apartment',
                        location: '123 Main St',
                        price: '\$1,000/mo',
                      ),
                      PropertyCard(
                        image: 'assets/images/property2.jpg',
                        title: 'Spacious 3BR House',
                        location: '456 Oak St',
                        price: '\$2,000/mo',
                      ),
                      PropertyCard(
                        image: 'assets/images/property3.jpg',
                        title: 'Cozy 1BR Studio',
                        location: '789 Elm St',
                        price: '\$800/mo',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Recent properties section
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Recent Properties',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                PropertyCard(
                  image: 'assets/images/property4.jpg',
                  title: 'Charming 2BR Cottage',
                  location: '987 Pine St',
                  price: '\$1,200/mo',
                ),
                SizedBox(height: 16.0),
                PropertyCard(
                  image: 'assets/images/property5.jpg',
                  title: 'Modern 1BR Loft',
                  location: '654 Maple St',
                  price: '\$900/mo',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String price;

  PropertyCard({
    required this.image,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    price,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
