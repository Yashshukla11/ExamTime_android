import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return contentBox(context);
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          // Wrap the Container with SingleChildScrollView
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Notifications',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'You have 3 new notifications',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}