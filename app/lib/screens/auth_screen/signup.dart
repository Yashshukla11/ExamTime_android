import 'dart:developer';

import 'package:examtime/screens/auth_screen/otp.dart';
import 'package:examtime/services/ApiServices/api_services.dart.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'signin.dart'; // Import your sign-in page here
import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = '/signup';

  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late bool passwordVisible;
  late bool passwordVisibleConfirm;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordVisible = false;
    passwordVisibleConfirm = false;
  }

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
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    width: 200,
                    height: 150,
                  ),
                  Form(
                    key: _formKey1,
                    child: TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Form(
                    key: _formKey2,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      controller: password,
                      obscureText: !passwordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisible
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Form(
                    key: _formKey3,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      validator: (value) {
                        if (value != password.text) {
                          return 'password should be match';
                        }
                        return null;
                      },
                      obscureText: !passwordVisibleConfirm,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            passwordVisibleConfirm
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              passwordVisibleConfirm = !passwordVisibleConfirm;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey1.currentState!.validate() &&
                          _formKey2.currentState!.validate() &&
                          _formKey3.currentState!.validate()) {
                        Apiservices.signupUser(
                                name: name.text,
                                email: email.text,
                                password: password.text,
                                context: context)
                            .then((value) {
                          log(value.toString());
                          if (value['isSign']) {
                            log("hlwww-----  " + value['token']);
                            Apiservices.sendOtp(
                              context,
                              value['token'],
                            );
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OTPPage(
                                token: value['token'],
                              ),
                            ));
                          }
                        });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    "Credentials should not be empty"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            });
                      }
                      Apiservices.signupUser(
                              name: name.text,
                              email: email.text,
                              password: password.text,
                              context: context)
                          .then((value) {
                        log(value.toString());
                        if (value['isSign']) {
                          log("hlwww-----  " + value['token']);
                          Apiservices.sendOtp(
                            context,
                            value['token'],
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OTPPage(
                                token: value['token'],
                              ),
                            ),
                          );
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: const Text('Sign Up'),
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
                    child: const Text(
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
