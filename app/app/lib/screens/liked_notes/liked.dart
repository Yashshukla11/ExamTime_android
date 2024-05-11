import 'package:flutter/material.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';

class LikedNotesPage extends StatelessWidget {
  static const String routeName = '/liked_notes';

  const LikedNotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
        return false;
      },
      child: Scaffold(
        appBar: CommonNavBar(),
        drawer: AppDrawer(), // Use the CommonNavBar for the app bar
        body: Center(
          child: Text(
            'Liked Notes Page',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
