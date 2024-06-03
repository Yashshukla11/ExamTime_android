import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:examtime/model/handle_likes.dart';
import 'package:flutter/material.dart';
import 'package:examtime/screens/landing_screen/dashboard.dart';
import 'package:examtime/screens/landing_screen/navbar.dart';
import 'package:examtime/screens/landing_screen/drawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../landing_screen/popupdetail.dart';

class LikedNotesPage extends StatefulWidget {
  static const String routeName = '/liked_notes';

  const LikedNotesPage({Key? key}) : super(key: key);

  @override
  State<LikedNotesPage> createState() => _LikedNotesPageState();
}

class _LikedNotesPageState extends State<LikedNotesPage> {
  List<Map<String, dynamic>> likedNotes = [];

  @override
  void initState() {
    super.initState();
    call();
  }
  Future<void> call() async {
    List<Map<String, dynamic>> notes = await HandleLikes.loadLikes();
    setState(() {
      likedNotes = notes;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonNavBar(),
      drawer: AppDrawer(), // Use the CommonNavBar for the app bar
      body: ListView.builder(
        itemCount: likedNotes.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showNoteDetails(context, likedNotes[index]);
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
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        likedNotes[index]["title"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            shareDownloadedPdf(likedNotes[index]["pdfUrl"],
                                likedNotes[index]["title"]);
                          },
                          icon: Icon(Icons.share_outlined)),
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () async {
                          var status = await Permission.storage.status;
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          }
                          var downloadPath = await getDownloadPath();
                          if (downloadPath != null) {
                            var filePath =
                                '$downloadPath/${likedNotes[index]["title"]}.pdf';
                            _sendDownloadNotification(
                                filePath); // Show initial notification
                            await _startDownload(
                                likedNotes[index]["pdfUrl"], filePath);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                  Text('Could not get download path')),
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
      )
    );
  }
  Future<void> shareDownloadedPdf(String pdfUrl, String title) async {
    try {
      final fileName = "$title.pdf";
      final appDocDir = await getApplicationDocumentsDirectory();
      final filePath = "${appDocDir.path}/$fileName";

      final response = await Dio().download(pdfUrl, filePath);
      if (response.statusCode == 200) {
        final xFile = XFile(filePath);
        await Share.shareXFiles([xFile]);
      } else {
        print("Problem in Downloading a file For sharing");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  void _showNoteDetails(BuildContext context, Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupDetail(
          title: note["title"],
          description: note["description"],
          pdfUrl: note["pdfUrl"],
          setController: (PDFViewController, TextEditingController) {},
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
}
