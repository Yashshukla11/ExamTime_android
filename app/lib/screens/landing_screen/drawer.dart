import 'dart:ui';
import 'package:examtime/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';
import 'package:examtime/screens/profile/profile.dart';
import 'package:flutter/widgets.dart';
import '../auth_screen/signin.dart';
import '../liked_notes/liked.dart';
import '../request_notes/request.dart';
import 'dashboard.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Drawer(
        width: media.width,
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5.0,
              sigmaY: 5,
            ),
            child: Stack(children: [
              SizedBox(
                height: media.width * 1,
              ),
              Container(
                width: media.width * 0.70,
                decoration: BoxDecoration(color: Colors.white),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(45),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: kTextTabBarHeight,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.network(
                                      'https://i.postimg.cc/2SMLF3mb/man.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    'John Doe',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.home),
                                title: Text('Home'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DashboardPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: Icon(Icons.account_circle),
                                title: Text('My Profile'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ProfileScreen.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: Icon(Icons.favorite),
                                title: Text('Liked Notes'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, LikedNotesPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: Icon(Icons.request_page),
                                title: Text('Request Notes'),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RequestNotesPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: Icon(Icons.logout),
                                title: Text('Logout'),
                                onTap: () {
                                  SharedServices.logout(context);
                                  Navigator.pushNamed(
                                      context, LoginPage.routeName);
                                },
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black26,
                          height: 1,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: kTextTabBarHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Switch Account",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Image.asset("assets/img/next.png",
                                      width: 18, height: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ])));
  }
}
