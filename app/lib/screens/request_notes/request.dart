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
enum SubLabel {
  DSA('DSA'),
  COA('COA'),
  C('C'),
  Cpp('C++'),
  Java('Java'),
  DS('Distributed Systems'),
  CN('Computer Networks'),
  DBMS('DBMS'),
  ML('Machine Learning'),
  OS('Operating System');

  final String label;
  const SubLabel(this.label);
}

enum ModeLabel {
  Printed('Printed'),
  Handwritten('Handwritten');
  final String label;
  const ModeLabel(this.label);
}

class _RequestNotesPageState extends State<RequestNotesPage> {
  final TextEditingController _noteController = TextEditingController();
  SubLabel? selectedSub = SubLabel.DSA;
  ModeLabel? selectedMode = ModeLabel.Printed;


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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0,),

              Row(
                children: [
                  Icon(Icons.book, size: 30.0,),
                  const SizedBox(width: 10),
                  Text(
                    'Subject',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<SubLabel>(
                value: selectedSub,
                onChanged: (SubLabel? newValue) {
                  setState(() {
                    selectedSub = newValue;
                  });
                },
                items: SubLabel.values.map((SubLabel subject) {
                  return DropdownMenuItem<SubLabel>(
                    value: subject,
                    child: Text(subject.label
                    ),
                  );
                }).toList(),
                hint: const Text('Select Subject'),
                isExpanded: true,
                autofocus: true,
                alignment: Alignment.centerLeft,
                style:  TextStyle(
                    color: Color(0xFF1F2937),

                    fontSize: 17.0),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.description, size: 30.0,),
                  const SizedBox(width: 10),
                  Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),

                     ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              DropdownButtonFormField<ModeLabel>(
                value: selectedMode,
                onChanged: (ModeLabel? newValue) {
                  setState(() {
                    selectedMode = newValue;
                  });
                },

                items: ModeLabel.values.map((ModeLabel mode) {
                  return DropdownMenuItem<ModeLabel>(
                    value: mode,
                    child: Text(mode.label),
                  );
                }).toList(),
                hint: const Text('Select Type'),
                isExpanded: true,
                autofocus: true,
                alignment: Alignment.centerLeft,
                style:  TextStyle(color: Color(0xFF1F2937),
                  fontSize: 17.0,
                ),



              ),
              const SizedBox(height: 20),

              TextField(
                controller: _noteController,
                cursorColor: Color(0xFF1F2937), // Set cursor color
                decoration:  InputDecoration(
                  labelText: 'Enter additional information',
                  labelStyle: TextStyle(
                    color: Color(0xFF1F2937), // Set label text color
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade200, // Set border color
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(7.0)),
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
                  style: TextStyle(color: Colors.white,
                  fontSize: 18.0,),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1F2937),
                  minimumSize: const Size(130, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              // const Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: Text(
              //     'Note Request Sent',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       color: Color(0xFF1F2937), // Set text color
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Your note request has been sent successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1F2937), // Set text color
                    fontSize: 17.0,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  side: const BorderSide(color: Color(0xFF1F2937)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
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
