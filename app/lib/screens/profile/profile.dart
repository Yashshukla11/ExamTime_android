import 'package:examtime/common_widget/custom_button.dart';
import 'package:examtime/common_widget/emailWidget.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  bool isEmail = true;

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
    var media = MediaQuery.sizeOf(context); // to get width and hight
    return Scaffold(
      appBar: CommonNavBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.yellow,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.postimg.cc/2SMLF3mb/man.png',
                        ),
                        radius: 95,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 35,
                        child: emailWidget(isEmail, context)),
                  ],
                ),
                SizedBox(height: 20),
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 16),
                CustomButton("Edit Profile", FontAwesomeIcons.userPen,
                    _editProfile, media.width, context),
                CustomButton("Terms and Conditions",
                    FontAwesomeIcons.fileInvoice, () {}, media.width, context),
                CustomButton(
                  "Privacy Policy",
                  FontAwesomeIcons.shieldHalved,
                  () {},
                  media.width,
                  context,
                ),
                CustomButton(
                  "LogOut",
                  FontAwesomeIcons.signOut,
                  () {},
                  media.width,
                  context,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
