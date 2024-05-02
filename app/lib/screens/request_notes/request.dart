import 'package:flutter/material.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';

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
                cursorColor: Color(0xFF1F2937), // Set cursor color
                decoration: const InputDecoration(
                  labelText: 'Enter your note request',
                  labelStyle: TextStyle(
                    color: Color(0xFF1F2937), // Set label text color
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF1F2937), // Set border color
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF1F2937), // Set border color
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
                  backgroundColor: Color(0xFF1F2937),
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
          backgroundColor: Colors.white, // Set background color to white
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Note Request Sent',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F2937), // Set text color
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your note request has been sent successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F2937), // Set text color
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
                      color: Color(0xFF1F2937),
                      // Set border color
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'OK',
                      style:
                          TextStyle(color: Color(0xFF1F2937)), // Set text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
