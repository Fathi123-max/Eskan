import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SearchButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 100, // Set the width of the Container
        decoration: BoxDecoration(
          color:
              Colors.white, // Replace this with your desired background color
          borderRadius:
              BorderRadius.circular(30), // Add a rounded rectangle shape
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.search,
            //     color: Colors.blue), // Replace this with your icon
            SizedBox(width: 8), // Add some spacing between icon and text
            Text(
              text,
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
