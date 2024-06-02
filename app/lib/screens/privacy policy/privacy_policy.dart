import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamTime Privacy Policy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PrivacyPolicyPage(),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Welcome to the Privacy Policy for the ExamTime Android app.'
              '\n\nYour Privacy:\n'
              'Your privacy is important to us. It is the policy of ExamTime to respect your privacy regarding any information we may collect from you through our app, ExamLimit Android. '
              'We do not collect personal information unless it is needed (e.g., when necessary for your academic needs and services). [...]'
              '\n\nInformation Collection and Use:\n'
              'For a better experience while using our service, we may require you to provide us with certain personally identifiable information. The information that we request will be retained by us and used as described in this privacy policy. [...]'
              '\n\nUser Contributions:\n'
              'Users have the option to upload their own notes to the ExamLimit platform. Please be aware that any content you upload is subject to being shared with other users. Exercise caution when sharing any personal information. [...]'
              '\n\nNote Requesting:\n'
              'You may request specific notes which, upon review, may be provided to you. The process of requesting and providing notes may involve the sharing and exchange of personal information between users. [...]'
              '\n\nContact Us:\n'
              'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us. [...]'
          ,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}