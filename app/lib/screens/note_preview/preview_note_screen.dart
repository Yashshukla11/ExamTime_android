import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PreviewNoteScreen extends StatefulWidget {
  const PreviewNoteScreen(this.note, {super.key});

  final Notes note;

  @override
  State<PreviewNoteScreen> createState() => _PreviewNoteScreenState();
}

class _PreviewNoteScreenState extends State<PreviewNoteScreen> {
  PDFViewController? pdfViewController;
  TextEditingController? pageNumberTextEditingController;

  /// This function is passed as a parameter to [PopupDetail] page where it is used to setup the controllers.
  void setControllers(
      PDFViewController pdfController, TextEditingController textController) {
    pdfViewController = pdfController;
    pageNumberTextEditingController = textController;
    setState(() {});
  }

  @override
  void dispose() {
    if (pageNumberTextEditingController != null) {
      pageNumberTextEditingController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          title: Text(
            widget.note.description,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            /// This action is responsible for displaying page number and allows user to jump to a page number
            Visibility(
              visible: pdfViewController != null,
              child: Center(
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
                        pageNumberTextEditingController!.text = pn.toString();
                      }
                      int? num;
                      int? pageCount = await pdfViewController!.getPageCount();
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
            ),
          ],
        ),
        body: Center(
          child: PopupDetail(
            setController: setControllers,
            title: widget.note.title,
            description: widget.note.description,
            pdfUrl: widget.note.pdfUrl,
          ),
        ),
      ),
    );
  }
}
