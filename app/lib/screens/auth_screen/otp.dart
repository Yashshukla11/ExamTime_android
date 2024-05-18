
import 'package:dio/dio.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/services/ApiServices/api_services.dart.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OTPPage extends StatelessWidget {
   OTPPage({super.key});
  static const String routeName = '/otp';
  TextEditingController otpController=TextEditingController();

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
                    keyboardType: TextInputType.number,
                    controller:otpController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Otp',
                      prefixIcon: Icon(Icons.password),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      bool verify=await Apiservices.verifyOtp(int.tryParse(otpController.text)??000);
                      if(verify && context.mounted){
                        Navigator.pushReplacementNamed(
                            context, DashboardPage.routeName);
                      }else if(context.mounted){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text("Otp verification failed , try again")));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    child: const Text('Verify'),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Apiservices.sendOtp();
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
