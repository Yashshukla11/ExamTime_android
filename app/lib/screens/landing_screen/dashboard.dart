import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/courses/btech_course.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:examtime/screens/note_preview/preview_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

import 'navbar.dart';
import 'drawer.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> notes = [
      {
        "pdfUrl":
            "https://www.yesterdaysclassics.com/previews/burt_poems_preview.pdf",
        "title": "Note 1",
        "description": "Description of Note 1",
      },
      {
        "pdfUrl": "https://www.clickdimensions.com/links/TestPDFfile.pdf",
        "title": "Note 2",
        "description": "Description of Note 2",
      },
      {
        "pdfUrl":
            "https://www.yesterdaysclassics.com/previews/burt_poems_preview.pdf",
        "title": "Note 1",
        "description": "Description of Note 1",
      },
      {
        "pdfUrl": "https://www.clickdimensions.com/links/TestPDFfile.pdf",
        "title": "Note 2",
        "description": "Description of Note 2",
      },
      {
        "pdfUrl":
            "https://www.yesterdaysclassics.com/previews/burt_poems_preview.pdf",
        "title": "Note 1",
        "description": "Description of Note 1",
      },
      {
        "pdfUrl": "https://www.clickdimensions.com/links/TestPDFfile.pdf",
        "title": "Note 2",
        "description": "Description of Note 2",
      },
    ];
    const imageLinks = [
      'assets/img/eng.png',
      'assets/img/diploma.png',
      'assets/img/doctor.png',
      'assets/img/nurs.png',
      'assets/img/phar.png',
    ];
    const stremas = ['BTech', 'Diploma', 'MBBS', 'Nursing', 'BPharma'];
    const pages = [
      BtexhCourse(),
    ];
    return WillPopScope(
      onWillPop: () async {
        return false; // Disables the back button
      },
      child: Scaffold(
          appBar: CommonNavBar(),
          drawer: AppDrawer(), // Use the CommonNavBar as the app bar
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GridView.builder(
                itemCount: 5,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => pages[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        //  color: Colors.amber,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 0.5,
                                  color: Color.fromARGB(255, 172, 172, 172))
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: Image.asset(
                                  imageLinks[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                stremas[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              child: Divider(),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodadipiscing elit, sed do eiusmod",
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
          //  ListView.builder(
          //   itemCount: notes.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return GestureDetector(
          //       onTap: () {
          //         // _showNoteDetails(context, notes[index]);
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => PreviewNoteScreen(Notes.fromMap(notes[index]))
          //           ),
          //         );
          //       },
          //       child: Container(
          //         margin: EdgeInsets.all(20),
          //         padding: EdgeInsets.all(20),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(10),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.5),
          //               spreadRadius: 5,
          //               blurRadius: 7,
          //               offset: Offset(0, 3),
          //             ),
          //           ],
          //         ),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             FadeInImage(
          //               image: NetworkImage(
          //                   'https://i.postimg.cc/43FzYStQ/pexels-cottonbro-3831847.jpg'),
          //               fit: BoxFit.cover,
          //               placeholder: const NetworkImage(
          //                   'https://placehold.jp/3d4070/ffffff/300x300.png?css=%7B%22border-radius%22%3A%2215px%22%7D'),
          //             ),
          //             Divider(), // Horizontal line to separate notes
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(
          //                   notes[index]["title"],
          //                   style: const TextStyle(
          //                     fontSize: 16,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //                 IconButton(
          //                   icon: const Icon(Icons.download),
          //                   onPressed: () async {
          //                     var status = await Permission.storage.status;
          //                     if (!status.isGranted) {
          //                       await Permission.storage.request();
          //                     }
          //                     var downloadPath = await getDownloadPath();
          //                     if (downloadPath != null) {
          //                       var filePath =
          //                           '$downloadPath/${notes[index]["title"]}.pdf';
          //                       _sendDownloadNotification(
          //                           filePath); // Show initial notification
          //                       await _startDownload(
          //                           notes[index]["pdfUrl"], filePath);
          //                     } else {
          //                       ScaffoldMessenger.of(context).showSnackBar(
          //                         SnackBar(
          //                             content:
          //                                 Text('Could not get download path')),
          //                       );
          //                     }
          //                   },
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
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

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');

        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> _startDownload(String url, String filePath) async {
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    _sendDownloadCompleteNotification(
        filePath); // Show download complete notification
  }

  void _sendDownloadNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel_id',
      'Download Channel',

      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      // Specify the small icon resource here
      showProgress: true,
      // Show download progress
      maxProgress: 100,
      // Max progress value
      indeterminate: false, // Make the progress bar determinate
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Show initial download notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Download in progress',
      'Your file is downloading...',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  void _sendDownloadCompleteNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'download_channel_id',
      'Download Channel',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Cancel the ongoing download notification
    await flutterLocalNotificationsPlugin.cancel(0);

    // Show download complete notification
    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Your file has been downloaded',
      platformChannelSpecifics,
      payload: filePath,
    );
  }

  Future<void> initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Use the response object here
        // For example, to open a file:
        await OpenFile.open(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse:
          (NotificationResponse response) async {
        // Use the response object here
        // For example, to open a file:
        await OpenFile.open(response.payload);
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DashboardPage().initNotification(); // Initialize notifications
  runApp(MaterialApp(
    home: DashboardPage(),
  ));
}
