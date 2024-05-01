import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'popupdetail.dart'; // Import the PopupDetail widget
import 'navbar.dart';
import 'drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration, replace this with data fetched from API
    List<Map<String, dynamic>> notes = [
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 1",
        "description": "Description of Note 1", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 2",
        "description": "Description of Note 2", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 1",
        "description": "Description of Note 1", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 2",
        "description": "Description of Note 2", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 1",
        "description": "Description of Note 1", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 2",
        "description": "Description of Note 2", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 1",
        "description": "Description of Note 1", // Add description for each note
      },
      {
        "image":
            "https://i.postimg.cc/8zBr2SZk/Screenshot-2024-03-26-at-11-04-11-AM.png",
        "title": "Note 2",
        "description": "Description of Note 2", // Add description for each note
      },
      // Add more notes data here as needed
    ];

    return Scaffold(
      appBar: CommonNavBar(),
      drawer: AppDrawer(), // Use the CommonNavBar as the app bar
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showNoteDetails(context, notes[index]);
            },
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    image: NetworkImage(notes[index]["image"]),
                    fit: BoxFit.cover,
                    placeholder: NetworkImage(
                        'https://placehold.jp/3d4070/ffffff/300x300.png?css=%7B%22border-radius%22%3A%2215px%22%7D'),
                  ),
                  Divider(), // Horizontal line to separate notes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notes[index]["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () {
                          // Add functionality for download button
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNoteDetails(BuildContext context, Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupDetail(
          title: note["title"],
          description: note["description"],
          imageUrl: note["image"], // Pass imageUrl to PopupDetail
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardPage(),
  ));
}
