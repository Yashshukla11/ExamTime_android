import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OTPPage extends StatelessWidget {
  static const String routeName = '/otp';

  const OTPPage({Key? key});

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
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    width: 200,
                    height: 150,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Otp',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: Text('Verify'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {

                    },
                    child: const Text(
                      'Didn\'t get an OTP? Resend it',
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
