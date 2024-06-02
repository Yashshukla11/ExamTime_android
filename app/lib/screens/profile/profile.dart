import 'package:examtime/common_widget/custom_button.dart';
import 'package:examtime/common_widget/emailWidget.dart';
import 'package:examtime/screens/auth_screen/signin.dart';
import 'package:examtime/screens/privacy%20policy/privacy_policy.dart';
import 'package:examtime/screens/terms%20and%20condition/terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';
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
          title: const Text('Edit Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  newName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
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
              child: const Text('Save'),
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
      appBar: const CommonNavBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    const CircleAvatar(
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
                const SizedBox(height: 20),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton("Edit Profile",
                    FontAwesomeIcons.userPen,
                    _editProfile,
                    media.width, context),
                CustomButton(
                    "Terms and Conditions",
                    FontAwesomeIcons.fileInvoice,
                        () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const TermsAndConditionsPage()),
                      );
                    }, media.width,
                    context),
                CustomButton(
                  "Privacy Policy",
                  FontAwesomeIcons.shieldHalved,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
                    );
                  },
                  media.width,
                  context,
                ),
                CustomButton(
                  "LogOut",
                  FontAwesomeIcons.signOut,
                      () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
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
