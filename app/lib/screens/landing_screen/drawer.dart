import 'package:examtime/screens/discussion/discussion.dart';
import 'dart:ui';
import 'package:examtime/model/user.dart';
import 'package:examtime/services/SharedServices/Sharedservices.dart';
import 'package:flutter/material.dart';
import 'package:examtime/screens/profile/profile.dart';
import 'package:provider/provider.dart';
import '../../helpers/ThemeProvider.dart';
import '../auth_screen/signin.dart';
import '../liked_notes/liked.dart';
import '../request_notes/request.dart';
import 'dashboard.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var media = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Close the drawer when tapping outside
      },
      child: Drawer(
        width: media.width,
        backgroundColor: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5,
          ),
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {}, // Prevent tap events from closing the drawer when interacting with it
                child: SizedBox(
                  height: media.width * 1,
                ),
              ),
              Container(
                width: media.width * 0.70,
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode ? Colors.grey[850] : Colors.white,
                ),
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
                                      SharedServices.getLoginDetails()?.user?.userPhoto ??
                                          'https://i.postimg.cc/2SMLF3mb/man.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Text(
                                    SharedServices.getLoginDetails()?.user?.username ?? 'user name',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
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
                                leading: const Icon(Icons.home),
                                title: const Text('Home'),
                                onTap: () {
                                  Navigator.pushNamed(context, DashboardPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: const Icon(Icons.account_circle),
                                title: const Text('My Profile'),
                                onTap: () {
                                  Navigator.pushNamed(context, ProfileScreen.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: const Icon(Icons.favorite),
                                title: const Text('Liked Notes'),
                                onTap: () {
                                  Navigator.pushNamed(context, LikedNotesPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: const Icon(Icons.request_page),
                                title: const Text('Request Notes'),
                                onTap: () {
                                  Navigator.pushNamed(context, RequestNotesPage.routeName);
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Logout'),
                                onTap: () {
                                  SharedServices.logout(context);
                                  Navigator.pushNamed(context, LoginPage.routeName);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.forum),
                                title: const Text('Discuss'),
                                onTap: () {
                                  Navigator.pushNamed(context, DiscussionPage.routeName);
                                },
                              ),
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Switch(
                                      value: themeProvider.isDarkMode,
                                      onChanged: (value) {
                                        themeProvider.toggleTheme(value);
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      themeProvider.isDarkMode ? "Dark mode" : "Light mode",
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
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
                          child: SizedBox(
                            height: kTextTabBarHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Switch Account",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Image.asset("assets/img/next.png", width: 18, height: 18),
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
      ),
    );
  }
}