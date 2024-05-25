import 'package:examtime/screens/discussion/discussion.dart';
import 'dart:ui';

import 'package:examtime/screens/profile/profile.dart';
import 'package:examtime/model/user.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';
import 'package:examtime/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        backgroundColor: Theme.of(context).colorScheme.background,
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
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: SizedBox(
                            height: kTextTabBarHeight,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 36,
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: Image.network(
                                      SharedServices.getLoginDetails()
                                              ?.user
                                              ?.userPhoto ??
                                          'https://i.postimg.cc/2SMLF3mb/man.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    SharedServices.getLoginDetails()
                                            ?.user
                                            ?.username ??
                                        'user name',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.home),
                                title: const Text('Home'),
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
                                title: const Text('My Profile'),
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
                                leading: Icon(Icons.lightbulb),
                                title: Text('Change Mode'),
                                onTap: () {
                              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
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
                               ListTile(
            leading: Icon(Icons.forum),
            title: Text('Discuss'),
            onTap: () {
              Navigator.pushNamed(context, DiscussionPage.routeName);
            },
          ),
                            ],
                          ),
                        ),
                        const Divider(
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
                                      fontWeight: FontWeight.w700),
                                ),
                                Image.asset("assets/img/next.png",
                                    width: 18, height: 18)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ],
            ),
          ),
         
      
              );
  }
}
