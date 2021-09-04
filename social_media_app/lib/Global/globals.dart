import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {
  static String uid;
  static String apiToken;
  //static User myself;
  static var firebaseUser;

  static void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
  }
}
