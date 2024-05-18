import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:examtime/common_widget/custom_button.dart';
import 'package:examtime/common_widget/emailWidget.dart';
import 'package:examtime/services/ApiServices/api_services.dart.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../model/user.dart';
import '../../services/SharedServices/Sharedservices.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'John Doe';
  String _email = 'john.doe@example.com';
  bool isEmail = true;
  User ?  user;

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
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void fetchUserDetails()async{
    if(SharedServices.isLoggedIn()){
      Response res=await Apiservices.fetchUserData();
      user=User.fromJson(jsonDecode(jsonEncode(res.data)));
      setState(() {});
      //print(user.username);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error occurred : please logout and login again ")));
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context); // to get width and hight
    return Scaffold(
      appBar: const CommonNavBar(),
      drawer: AppDrawer(),
      body: user==null?const Center(
        child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),
      ):SingleChildScrollView(
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
                          user?.userPhoto??'https://i.postimg.cc/2SMLF3mb/man.png',
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
                  user!.username??_name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  user?.email??_email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
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
