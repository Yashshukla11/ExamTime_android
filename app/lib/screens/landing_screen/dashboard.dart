import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:examtime/screens/note_preview/preview_note_screen.dart';
import 'package:examtime/services/ApiServices/api_services.dart.dart';
import 'package:examtime/services/SharedServices/Preferences.dart';
import 'package:examtime/services/notification_service.dart';
import 'package:dio/dio.dart';
import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../helpers/ThemeProvider.dart';
import '../../model/user.dart';
import '../../services/SharedServices/Sharedservices.dart';
import 'navbar.dart';
import 'drawer.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController _searchController = TextEditingController();
  late FocusNode focusNode;
  bool isInFocus = false;
  List<dynamic> notes = [];
  List<dynamic> filteredNotes = [];
  User? user;
  bool isLoading = true;
  List<String> likedNotes = [];
  List<String> likedStatus = [];

  fetchNotes() async {
    if (SharedServices.isLoggedIn()) {
      Response res = await Apiservices.fetchNotes();
      notes = jsonDecode(jsonEncode(res.data));
      filteredNotes = notes;
      isLoading = false;
      setState(() {});
      if (kDebugMode) {
        print(notes);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error occurred : please logout and login again ")));
    }
  }

  getLikedNotes() {
    likedNotes =
        (preferences?.getStringList(SharedServices.LIKED_NOTES)) ?? likedNotes;
    likedStatus = likedNotes;
  }

  @override
  void initState() {
    super.initState();
    getLikedNotes();
    fetchNotes();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        isInFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
    focusNode.dispose();
  }

  void _filterNotes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredNotes = notes;
      } else {
        filteredNotes = notes.where((note) {
          return note['title'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _unfocusSearchBar() {
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        return false; // Disables the back button
      },
      child: Scaffold(
        appBar: const CommonNavBar(),
        drawer: const AppDrawer(), // Use the CommonNavBar as the app bar
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 2,
                ),
              )
            : notes.isEmpty
                ? const Center(
                    child: Text("No notes are available"),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _searchController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Search Notes ...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          onChanged: (value) {
                            _filterNotes(); // Call filter method on text change
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredNotes.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PreviewNoteScreen(
                                          Notes.fromMap(filteredNotes[index]))),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode ? Colors.grey[850] : Colors.white,
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const FadeInImage(
                                      image: NetworkImage(
                                          'https://i.postimg.cc/43FzYStQ/pexels-cottonbro-3831847.jpg'),
                                      fit: BoxFit.cover,
                                      placeholder: NetworkImage(
                                          'https://placehold.jp/3d4070/ffffff/300x300.png?css=%7B%22border-radius%22%3A%2215px%22%7D'),
                                    ),
                                    const Divider(), // Horizontal line to separate notes
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.3,
                                          child: Text(
                                            filteredNotes[index]["title"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                likedStatus.contains(
                                                        filteredNotes[index]
                                                            ['fileUrl'])
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: likedStatus.contains(
                                                        filteredNotes[index]
                                                            ['fileUrl'])
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                              onPressed: () {
                                                _toggleLikedStatus(
                                                    filteredNotes[index]
                                                        ['fileUrl']);
                                              },
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  shareDownloadedPdf(
                                                      filteredNotes[index]
                                                          ["fileUrl"],
                                                      filteredNotes[index]
                                                          ["title"]);
                                                },
                                                icon: const Icon(
                                                    Icons.share_outlined)),
                                            IconButton(
                                              icon: const Icon(Icons.download),
                                              onPressed: () async {
                                                var status = await Permission
                                                    .storage.status;
                                                if (!status.isGranted) {
                                                  await Permission.storage
                                                      .request();
                                                }
                                                var downloadPath =
                                                    await getDownloadPath();
                                                if (downloadPath != null) {
                                                  var filePath =
                                                      '$downloadPath/${notes[index]["title"]}.pdf';
                                                  LocalNotificationService()
                                                      .sendDownloadNotification(
                                                          filePath,
                                                          filteredNotes[index][
                                                              "title"]); // Show initial notification
                                                  await _startDownload(
                                                      filteredNotes[index]
                                                              ["fileUrl"] ??
                                                          "",
                                                      filePath,
                                                      filteredNotes[index]
                                                          ["title"]);
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Could not get download path')),
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
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

  void _toggleLikedStatus(String fileUrl) {
    if (!likedStatus.contains(fileUrl)) {
      SharedServices.addLikedNotes(context, fileUrl);
      likedStatus.add(fileUrl);
    } else {
      SharedServices.removeLikedNotes(context, fileUrl);
      likedStatus.remove(fileUrl);
    }
    setState(() {});
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

  Future<void> _startDownload(
      String url, String filePath, String fileName) async {
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    LocalNotificationService().sendDownloadCompleteNotification(
        filePath, fileName); // Show download complete notification
  }
}
