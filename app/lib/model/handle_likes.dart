import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HandleLikes {

  static Future<List<Map<String, dynamic>>> loadLikes() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonString = pref.getString("likes");
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      print("From loadlikes : ${jsonList}");
      return jsonList.map((json) => Map<String, dynamic>.from(json)).toList();
    }
    return [];
  }

  static Future<void> saveLikes(List<Map<String, dynamic>> temp) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final jsonString = json.encode(temp);
    pref.setString("likes", jsonString);
  }
  static Future<void> addLikes(Map<String, dynamic> like) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final likes = await loadLikes();
    bool isDuplicate = likes.any((element) => element["title"] == like["title"]);
    if (!isDuplicate) {
      likes.add(like);
      final jsonString = jsonEncode(likes);
      await pref.setString("likes", jsonString);
    }
  }

  static Future<bool> isMarked(String title) async {
    final likes = await loadLikes();
    bool check  = likes.any((element) => element["title"] == title);
    return check;
  }

  static Future<void> deleteLikes(String title) async {
    final like = await loadLikes();
    like.removeWhere((element) => element["title"] == title);
    await saveLikes(like);
  }
}