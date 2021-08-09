import 'package:flutter/cupertino.dart';
import 'package:social_media_app/models/user.dart';

class MetaData with ChangeNotifier{
  User myself;

  void setMyself(User user){
    myself = user;
    notifyListeners();
  }

}