import 'package:flutter/material.dart';



class ExamItem {
  final IconData icon;
  final String text;

  ExamItem(this.icon, this.text);
}

class ExamTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamTime Terms & Conditions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TermsAndConditionsPage(),
    );
  }
}

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Welcome to ExamTime, your digital pathway to an enhanced learning experience. This terms and conditions are a contract between you and ExamTime Android Application ("we", "our", or "us").'
              '\n\nAcceptance of Terms:\n'
              'By accessing and using our services, you agree to comply with these terms and conditions. [...]'
              '\n\nDescription of Service:\n'
              'ExamTime offers a virtual platform for students to efficiently access, upload, request, and download their academic study materials tailored to their courses and educational institution. [...]'
              '\n\nAccount Responsibilities:\n'
              'You are solely responsible for all activities that occur under your account and for keeping your password secure. Do not disclose your account credentials to others. [...]'
              '\n\nUser-Generated Content:\n'
              "While using ExamTime's services, you may upload study materials such as notes, documents, or other academic content. It is your responsibility to ensure that any content you upload does not infringe on any copyright or intellectual property rights. [...]"
              '\n\nProhibitions:\n'
              'You may not misuse the services provided through ExamTime. This includes not engaging in illegal activities, violating the privacy of others, or attempting to breach the security mechanisms of the service. [...]'
              '\n\nPlease read the complete terms of service carefully to understand our practices and your rights.'
          ,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}