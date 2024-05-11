import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Import corrected here
import 'package:http/http.dart' as http;

class PopupDetail extends StatefulWidget {
  final String title;
  final String description;
  final String pdfUrl;

  const PopupDetail({
    Key? key,
    required this.title,
    required this.description,
    required this.pdfUrl,
  }) : super(key: key);

  @override
  _PopupDetailState createState() => _PopupDetailState();
}

class _PopupDetailState extends State<PopupDetail> {
  String? path;
  bool isLoading = true; // Added for better loading indication

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    try {
      var tempDir = await getTemporaryDirectory();
      var tempPath = tempDir.path;
      var filePath = '$tempPath/${widget.title}.pdf';
      var response = await http.get(Uri.parse(widget.pdfUrl));

      if (response.statusCode == 200) {
        var file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          path = filePath;
          isLoading = false; // Updated when loading completes
        });
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      print('Error loading PDF: $e');
      setState(() {
        isLoading = false; // Handle loading error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: 300,
              child: path != null
                  ? PDFView(
                      filePath: path!,
                      autoSpacing: true,
                      pageFling: true,
                      swipeHorizontal: true,
                    )
                  : Text('Failed to load PDF'),
            ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
