import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:flutter/material.dart';

class RequestNotesPage extends StatefulWidget {
  static const String routeName = '/request_notes';

  const RequestNotesPage({Key? key}) : super(key: key);

  @override
  _RequestNotesPageState createState() => _RequestNotesPageState();
}

class _RequestNotesPageState extends State<RequestNotesPage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
        return false;
      },
      child: Scaffold(
        appBar: CommonNavBar(),
        drawer: AppDrawer(), // Use the CommonNavBar
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _noteController,
                cursorColor: Theme.of(context).colorScheme.secondary, // Set cursor color
                decoration: InputDecoration(
                  labelText: 'Enter your note request',
                  labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, // Set border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary, // Set border color
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _submitNoteRequest(context);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitNoteRequest(BuildContext context) {
    // Add functionality to submit the note request
    _showNoteRequestSentDialog(context);
    _noteController.clear();
  }

  void _showNoteRequestSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background, 
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Note Request Sent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary, // Set text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: 
                Text(
                  'Your note request has been sent successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Theme.of(context).colorScheme.secondary, // Set text color
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      // Set border color
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'OK',
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.secondary)
                  ),
                ),
              ),
          )],
          ),
        );
      },
    );
  }
}
