import 'dart:ui';

import 'package:examtime/screens/landing_screen/drawer.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    String? _selectedOption;
    List<String> dropDownList = ['COA', 'Maths4', 'English'];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonNavBar(),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.04,
            ),
            //title
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'COA Notes Btech. 2nd Year',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText:
                      'Handwritten COA notes with all units complete', // Set prefixText instead of hintText
                  hintStyle: TextStyle(
                      color: Colors.grey), // Style for the prefix text
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 100.0), // Adjust the vertical padding here
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            //DROPDOWN
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Subject',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: DropdownButton<String>(
                value: _selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue;
                  });
                },
                items:
                    dropDownList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  'Select a subject',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                underline: Container(), // Removes the underline
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            const Text(
              "Did'nt find the subject add your own",
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.w400),
            ),

            //SUBJECT ADDING SECTION

            Row(
              children: [
                Container(
                  height: 50,
                  width: size.width * 0.5,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'COA Notes Btech. 2nd Year',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 33, 65, 243),
                      borderRadius: BorderRadius.circular(6)),
                  child: TextButton(
                    onPressed: () {
                      // Action to perform when button is pressed
                      print('Text Button pressed');
                    },
                    child: Text(
                      'Text Button',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            //COURSE SECTION
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Course',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Btech.',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //YEAR SECTION
            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Year',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Btech.',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            //UPLOADING SECTION
            const SizedBox(
              height: 30,
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: Text(
                'Upload File',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'png'],
                );

                if (result != null) {
                  File file = File(result.files.single.path!);
                  // Handle the selected file (e.g., upload it or display its contents)
                } else {
                  // User canceled the picker
                }
              },
              child: Text('Select File'),
            ),
          ],
        ),
      ),
    );
  }
}
