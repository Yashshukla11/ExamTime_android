import 'package:examtime/model/notes.dart';
import 'package:examtime/screens/landing_screen/popupdetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreviewNoteScreen extends StatefulWidget {
  const PreviewNoteScreen(this.note,{super.key});
  final Notes note;
  @override
  State<PreviewNoteScreen> createState() => _PreviewNoteScreenState();
}

class _PreviewNoteScreenState extends State<PreviewNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        title: Text(widget.note.title,style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                child: Text(widget.note.description,style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ),
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
