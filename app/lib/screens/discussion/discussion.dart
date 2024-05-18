// discussion_page.dart
import 'package:flutter/material.dart';

import 'comments.dart';

class DiscussionPage extends StatefulWidget {
    static const String routeName = '/disscussion';

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  List<Comment> comments = [];
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  void _addComment() {
    final username = _usernameController.text;
    final content = _commentController.text;

    if (username.isNotEmpty && content.isNotEmpty) {
      setState(() {
        comments.add(Comment(
          username: username,
          content: content,
          timestamp: DateTime.now(),
        ));
      });

      _usernameController.clear();
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discussion'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.username),
                  subtitle: Text(comment.content),
                  trailing: Text(
                    "${comment.timestamp.hour}:${comment.timestamp.minute}",
                    style: TextStyle(fontSize: 12),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Discuss here',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
