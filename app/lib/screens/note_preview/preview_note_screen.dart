import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewNoteScreen extends StatefulWidget {
  const PreviewNoteScreen(this.note, {super.key});

  final Notes note;

  @override
  State<PreviewNoteScreen> createState() => _PreviewNoteScreenState();
}

class _PreviewNoteScreenState extends State<PreviewNoteScreen> {
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
      ),
      body: Column(
        children: [
          Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: PopupDetail(
                    title: widget.note.title,
                    description: widget.note.description,
                    pdfUrl: widget.note.pdfUrl,
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}
