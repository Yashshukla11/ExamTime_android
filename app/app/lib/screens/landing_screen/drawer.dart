import 'package:flutter/material.dart';
import 'package:examtime/screens/profile/profile.dart';

import '../auth_screen/signin.dart';
import '../liked_notes/liked.dart';
import '../request_notes/request.dart';
import 'dashboard.dart';

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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, DashboardPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Liked Notes'),
            onTap: () {
              Navigator.pushNamed(context, LikedNotesPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.request_page),
            title: Text('Request Notes'),
            onTap: () {
              Navigator.pushNamed(context, RequestNotesPage.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
