import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Color(0xFF1F2937), // Header background color
            padding: EdgeInsets.symmetric(vertical: 40),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://i.postimg.cc/2SMLF3mb/man.png',
                    // Your network image URL
                  ),
                  radius: 36,
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              // Navigate to the My Profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Liked Notes'),
            onTap: () {
              // Navigate to the Liked Notes screen
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Request Notes'),
            onTap: () {
              // Navigate to the Request Notes screen
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Log out the user
            },
          ),
        ],
      ),
    );
  }
}
