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

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    var filePath = '$tempPath/${widget.title}.pdf';
    var response = await http.get(Uri.parse(widget.pdfUrl));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      path = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: path != null
          ? CircularProgressIndicator()
          : Container(
              height: 300,
              child: PDFView(
                filePath: path!, // Corrected to 'filePath'
                autoSpacing: true,
                pageFling: true,
                swipeHorizontal: true,
              ),
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
