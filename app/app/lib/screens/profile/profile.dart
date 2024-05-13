import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/landing_screen/notification.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';

  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = _name;
        String newEmail = _email;
        return AlertDialog(
          title: Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  newName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  newEmail = value;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _name = newName;
                  _email = newEmail;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
        return false;
      },
      child: Scaffold(
        appBar: CommonNavBar(),
        drawer: AppDrawer(),
        body: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.postimg.cc/2SMLF3mb/man.png',
                ),
                radius: 50,
              ),
            ),
            SizedBox(height: 50),
            Text(
              _name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _editProfile,
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
