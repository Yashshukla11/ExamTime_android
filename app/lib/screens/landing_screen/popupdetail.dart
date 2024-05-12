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

  PDFViewController? pdfViewController;
  TextEditingController pageNumberTextEditingController =
      TextEditingController(text: "1");
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: path != null
                      ? PDFView(
                          onRender: (pages) => {},
                          onViewCreated: (controller) {
                            pdfViewController = controller;
                          },
                          onPageChanged: (page, total) {
                            pageNumberTextEditingController.text =
                                (page! + 1).toString();
                            setState(() {});
                          },
                          filePath: path!,
                          autoSpacing: true,
                          pageFling: true,
                          swipeHorizontal: true,
                        )
                      : const Text('Failed to load PDF'),
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.white,
                    child: TextFormField(
                      controller: pageNumberTextEditingController,
                      // cursorHeight: 5,
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,

                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (value) async {
                        if (value.trim().isEmpty) {
                          int? pn = await pdfViewController!.getCurrentPage();
                          pageNumberTextEditingController.text = pn.toString();
                        }
                        int? num;
                        int? pageCount =
                            await pdfViewController!.getPageCount();
                        num = int.tryParse(value.trim());

                        setState(() {
                          if (num != null &&
                              num! - 1 >= 0 &&
                              num! - 1 < pageCount!) {
                            num = num! - 1;
                            pdfViewController!.setPage(num!);
                          } else if (num! - 1 > pageCount!) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Maximum page size is $pageCount"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid page number"),
                            ));
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
