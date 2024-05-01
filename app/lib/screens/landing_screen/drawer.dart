import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
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
