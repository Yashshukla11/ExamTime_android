import 'dart:convert';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import '../../services/ApiServices/api_services.dart.dart';

class Request {
  String author;
  String description;

  Request(this.author, this.description);
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Request> requestList = [];
  bool isLoading = true;
  bool isScrolling=false;

  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ),
          ) :requestList.isEmpty?const Center(
            child: Text(
              'You Have No Notifications  Thank you!!',
              style: TextStyle(fontSize: 18,color: Colors.blueAccent,fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ):
          Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
          Text(
            'You have ${requestList.length} new notifications',
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22),
          Expanded(
            child: ListView.builder(
              itemCount:isScrolling?requestList.length:(requestList.length>=4?4:requestList.length),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black26,width: 2)
                    )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(toBeginningOfSentenceCase(requestList[requestList.length-index-1].description)??requestList[requestList.length-index-1].description,
                          style: const TextStyle(color: Colors.black,fontSize: 18,overflow: TextOverflow.ellipsis,),maxLines: 3,),
                      ),
                      Text('@${requestList[requestList.length-index-1].author}',
                        style: const TextStyle(color: Colors.black,fontSize: 12,overflow: TextOverflow.ellipsis,),maxLines: 3,),
                    ],
                  )
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: isScrolling?TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
            ):TextButton(
              onPressed: () {
                setState(() {
                  isScrolling=true;
                });
              },
              child: const Text(
                'View more...',
                style: TextStyle(fontSize: 18,color: Colors.blue),
              ),
            ),
          ),
                      ],
                    ),
        ],
      ),
    );
  }

  Future<void> getRequests() async {
    Response res = await Apiservices.fetchRequests();
    List<dynamic> data = jsonDecode(jsonEncode(res.data));
    for (var item in data) {
      String username = item['author']['username'];
      String description = item['description'];
      requestList.add(Request(username, description));
    }
    setState(() {
      isLoading = false;
    });
  }
}
