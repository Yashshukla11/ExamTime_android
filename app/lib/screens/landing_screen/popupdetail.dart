import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Import corrected here
import 'package:http/http.dart' as http;

class PopupDetail extends StatefulWidget {
  final String title;
  final String description;
  final String pdfUrl;
  final Function(PDFViewController, TextEditingController) setController;
  PopupDetail({
    Key? key,
    required this.title,
    required this.description,
    required this.pdfUrl,
    required this.setController,
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

  TextEditingController pageNumberTextEditingController =
      TextEditingController(text: "1");
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: path != null
                ? PDFView(
                    onRender: (pages) => {},
                    onViewCreated: (controller) {
                      widget.setController(
                          controller, pageNumberTextEditingController);
                    },
                    onPageChanged: (page, total) {
                      pageNumberTextEditingController.text =
                          (page! + 1).toString();
                      setState(() {});
                    },
                    filePath: path!,
                    autoSpacing: true,
                    pageFling: true,
                    swipeHorizontal: false,
                  )
                : const Text('Failed to load PDF'),
          );
  }
}
