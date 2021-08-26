import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/Global/globals.dart';
import 'package:social_media_app/models/http_helper.dart';
import 'package:social_media_app/models/secureStorage.dart';

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  bool _isSigningIn;

  // var _apiToken;

  GoogleSignInProvider() {
    _isSigningIn = false;
    // _apiToken = '';
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool isSigningIn) {
    _isSigningIn = isSigningIn;
    notifyListeners();
  }

  // String get apiToken => _apiToken;

  Future login() async {
    isSigningIn = true;

    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        isSigningIn = false;
        return;
      } else {
        final googleAuth = await user.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final currentUser = FirebaseAuth.instance.currentUser;

        // if (currentUser.email.endsWith('tkmce.ac.in'))
        return {"email": currentUser.email, "uid": currentUser.uid};
        // else {
        //   Fluttertoast.showToast(
        //     msg: 'Please use @tkmce.ac.in email',
        //   );
        //   print('Non TKMCE member');
        //   currentUser.delete();
        //   logout();
        // }
        // if (authResult.additionalUserInfo.isNewUser) {
        //   //
        // } else {
        //   final response = await HttpHelper.post(uri: '/auth/login', body: {
        //     'email': '${currentUser.email}',
        //     'uid': '${currentUser.uid}',
        //   });
        //   final responseDecoded = jsonDecode(response.body);
        //   SecureStorage.setApiToken(response.headers['x-auth-token']);
        //   SecureStorage.setUid(responseDecoded['_id']);
        //   Global.apiToken = response.headers['x-auth-token'];
        //   Global.uid = responseDecoded['_id'];
        //   print(Global.uid);
        //   print(Global.apiToken);
        // }
      }
    } on PlatformException catch (err) {
      var message = 'An error has occured';

      if (err.message != null) {
        message = err.message;
      }
      print(message);
    } catch (err) {
      print(err);
    } finally {
      isSigningIn = false;
    }
  }

  void logout() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      print('logout successful');
      print(FirebaseAuth.instance.currentUser);
      await SecureStorage.deleteAll();
    } catch (err) {
      print(err);
    }
  }

  void deleteUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    currentUser.delete();
  }
}
