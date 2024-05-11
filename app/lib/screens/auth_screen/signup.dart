import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'signin.dart'; // Import your sign-in page here
import 'package:examtime/screens/landing_screen/dashboard.dart'; // Import the DashboardPage here

class SignUpPage extends StatelessWidget {
  static const String routeName = '/signup';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://i.postimg.cc/02pnpHXG/logo-1.png',
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    width: 200,
                    height: 150,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: Text('Sign Up'),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Already have an account? Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
