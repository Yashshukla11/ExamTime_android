import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:examtime/screens/note_preview/preview_note_screen.dart';
import 'package:examtime/services/ApiServices/api_services.dart.dart';
import 'package:examtime/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

import '../../model/user.dart';
import '../../services/SharedServices/Sharedservices.dart';
import 'navbar.dart';
import 'drawer.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

   DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List< dynamic> notes =[];
  User ? user;
  bool isLoading=true;
  fetchNotes()async{
    if(SharedServices.isLoggedIn()){
      Response res=await Apiservices.fetchNotes();
      notes=jsonDecode(jsonEncode(res.data));
      isLoading=false;
     // print(notes);
      setState(() {});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error occurred : please logout and login again ")));
    }
  }
  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Disables the back button
      },
      child: Scaffold(
        appBar: const CommonNavBar(),
        drawer: AppDrawer(), // Use the CommonNavBar as the app bar
        body: isLoading?const Center(child: CircularProgressIndicator(color: Colors.blue,strokeWidth: 2,),)
        :notes.isEmpty?const Center(child: Text("No notes are available"),):ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewNoteScreen(Notes.fromMap(notes[index]))
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FadeInImage(
                      image: NetworkImage(
                          'https://i.postimg.cc/43FzYStQ/pexels-cottonbro-3831847.jpg'),
                      fit: BoxFit.cover,
                      placeholder: NetworkImage(
                          'https://placehold.jp/3d4070/ffffff/300x300.png?css=%7B%22border-radius%22%3A%2215px%22%7D'),
                    ),
                    Divider(), // Horizontal line to separate notes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notes[index]['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                                  '$downloadPath/${notes[index]["title"]}.pdf';
                              LocalNotificationService().sendDownloadNotification(
                                  filePath,notes[index]["title"]); // Show initial notification
                              await _startDownload(
                                  notes[index]["fileUrl"]??"", filePath,notes[index]["title"]);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
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
        ),
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

        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<void> _startDownload(String url, String filePath,String fileName) async {
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    LocalNotificationService().sendDownloadCompleteNotification(
        filePath,fileName); // Show download complete notification
  }
}
