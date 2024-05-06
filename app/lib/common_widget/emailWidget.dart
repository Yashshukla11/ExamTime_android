import 'package:flutter/material.dart';

Widget emailWidget(bool isEmail, BuildContext context) {
  if (isEmail) {
    return Container(
      padding: const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.verified,
            color: Colors.green,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Email Verified",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // Email is not verified this statement will run
  return GestureDetector(
    onTap: () {
      // link for verification of email
    },
    child: Container(
      padding: const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.cancel_rounded,
            color: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Verify Email",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
