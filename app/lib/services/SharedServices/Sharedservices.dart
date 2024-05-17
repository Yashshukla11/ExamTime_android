import 'dart:convert';

import 'package:examtime/model/user.dart';
import 'package:examtime/services/SharedServices/Preferences.dart';
import 'package:flutter/material.dart';

//**************************************************************************** *//
//EMPORTANT                 //EMPORTANT                    //EMPORTANT

//%%%%%%%%%%%$$$$$$$$$$$$$###############@@@@@@@@@@@@@@@@@@@@@@@@@

//write this two line in main function

//------>>>     WidgetsFlutterBinding.ensureInitialized();
//---->>>     preferences = await SharedPreferences.getInstance();

//%%%%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$########################

class SharedServices {
//set all the login details-----------------------------------
  static const  String LIKED_NOTES='likedNotes';
  static Future<void> setLoginDetails(UserModel? usermodel) async {
    if (usermodel != null) {
      preferences!.setString("login_details", jsonEncode(usermodel.toJson()));
    }
  }

// get the login details------------------------------------
  static UserModel? getLoginDetails() {
    String? jsonDetails = preferences!.getString("login_details");
    if (jsonDetails != null) {
      return UserModel.fromJson(jsonDecode(jsonDetails));
    }
    return null;
  }

//for login check//----------------------------------------
  static bool isLoggedIn() {
    return preferences!.getString("login_details") != null ? true : false;
  }

//for logout//--------------------------------------------
  static Future<bool> logout(BuildContext context) async {
    await preferences!.clear();
    return true;
  }

  static removeLikedNotes(BuildContext context,String fileUrl){
    List<String>?list=preferences?.getStringList(LIKED_NOTES);
    if(list!=null){
      list.remove(fileUrl);
      preferences?.setStringList(LIKED_NOTES,list);
    }
  }
  static addLikedNotes(BuildContext context,String fileUrl){
     List<String>?list=preferences?.getStringList(LIKED_NOTES);
     if(list==null){
       List<String>temp=[fileUrl];
       preferences?.setStringList(LIKED_NOTES,temp);
     }else{
       list.add(fileUrl);
       preferences?.setStringList(LIKED_NOTES,list);
     }
  }
}
