import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'navbar.dart';
import 'drawer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration, replace this with data fetched from API
    List<Map<String, dynamic>> notes = [
      {
        "pdfUrl":
            "https://www.yesterdaysclassics.com/previews/burt_poems_preview.pdf",
        "title": "Note 1",
        "description": "Description of Note 1", // Add description for each note
      },
      {
        "pdfUrl": "https://www.clickdimensions.com/links/TestPDFfile.pdf",
        "title": "Note 2",
        "description": "Description of Note 2", // Add description for each note
      },
      // Add more notes data here as needed
    ];

    return Scaffold(
      appBar: CommonNavBar(),
      drawer: AppDrawer(), // Use the CommonNavBar as the app bar
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showNoteDetails(context, notes[index]);
            },
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    image: NetworkImage(
                        'https://i.postimg.cc/43FzYStQ/pexels-cottonbro-3831847.jpg'),
                    fit: BoxFit.cover,
                    placeholder: const NetworkImage(
                        'https://placehold.jp/3d4070/ffffff/300x300.png?css=%7B%22border-radius%22%3A%2215px%22%7D'),
                  ),
                  Divider(), // Horizontal line to separate notes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notes[index]["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.download),
                        onPressed: () async {
                          var status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          }
                          var downloadPath = await getDownloadPath();
                          if (downloadPath != null) {
                            var filePath =
                                '$downloadPath/${notes[index]["title"]}.pdf';
                            var response = await http
                                .get(Uri.parse(notes[index]["pdfUrl"]));
                            var file = File(filePath);
                            await file.writeAsBytes(response.bodyBytes);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Downloaded to $filePath')),
                            );
                            // Open the PDF file with default PDF viewer app
                            _launchPDF(filePath);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Could not get download path')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNoteDetails(BuildContext context, Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupDetail(
          title: note["title"],
          description: note["description"],
          pdfUrl: note["pdfUrl"],
        );
      },
    );
  }

  // Function to launch PDF file with default PDF viewer app
  void _launchPDF(String filePath) {
    if (Platform.isAndroid) {
      Process.run(
          'am', ['start', '-a', 'android.intent.action.VIEW', filePath]);
    } else if (Platform.isIOS) {
      // Launch the file on iOS (not implemented in this example)
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardPage(),
  ));
}
