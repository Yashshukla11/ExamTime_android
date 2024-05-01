import 'package:flutter/material.dart';

class PopupDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl; // Add imageUrl parameter

  const PopupDetail({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl, // Add required imageUrl parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            // Adjust the radius as needed
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Divider(), // Add spacing
          Text(description), // Display description
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
