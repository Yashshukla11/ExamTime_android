import 'package:examtime/screens/request_notes/request.dart';
import 'package:flutter/material.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/liked_notes/liked.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:examtime/screens/auth_screen/signin.dart';
import 'package:examtime/screens/auth_screen/signup.dart';
import 'package:examtime/screens/profile/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExamTime',
      theme: ThemeData(
        primaryColor: const Color(0xFF1F2937),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        DashboardPage.routeName: (context) => DashboardPage(),
        LoginPage.routeName: (context) => LoginPage(),
        SignUpPage.routeName: (context) => SignUpPage(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        LikedNotesPage.routeName: (context) => LikedNotesPage(),
        RequestNotesPage.routeName: (context) => RequestNotesPage(),
      },
    );
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backgroundColorAnimation = ColorTween(
      begin: Color(0xFF1F2937),
      end: Theme.of(context).primaryColor,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColorAnimation.value ?? Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: 'https://i.postimg.cc/02pnpHXG/logo-1.png',
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to ExamTime!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
