import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/Registration/end.dart';
import 'package:social_media_app/screens/Registration/intro.dart';
import 'package:social_media_app/screens/Registration/step1.dart';
import 'package:social_media_app/screens/Registration/step2.dart';
import 'package:social_media_app/screens/Registration/step3.dart';

final user = {};

class RegistrationScreen extends StatefulWidget {
  bool isGoogleRegistered;
  String emailValue;
  Function onRegistrationComplete;
  User user;
  Function onRegistrationError;
  RegistrationScreen(bool isGoogleRegistered,
      {this.user,
      String email = '',
      this.onRegistrationError,
      @required this.onRegistrationComplete}) {
    this.isGoogleRegistered = isGoogleRegistered;
    this.emailValue = email;
  }
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var user = User(userName: '', name: '', email: '', skills: []);

  var isNameValid = true;
  var isUsernameValid = true;
  var isEmailValid = true;

  var isUsernameAvailable = false;

  List<Widget> pages;
  int page;

  ImagePicker picker;
  XFile pickedImage;

  @override
  void initState() {
    page = (widget.isGoogleRegistered) ? 1 : 0;
    user.email = widget.emailValue;
    super.initState();
    if (widget.user != null) {
      user = widget.user;
    }

    picker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      intro(
        primaryButtonOnPressed: () {
          setState(() {
            page++;
          });
        },
      ),
      step1(
        isUsernameAvailable: isUsernameAvailable,
        emailIsValid: isEmailValid,
        nameIsValid: isNameValid,
        usernameIsValid: isUsernameValid,
        nameValue: user.name,
        emailValue: user.email,
        usernameValue: user.userName,
        primaryButtonOnPressed: () {
          if (isEmailValid &&
              isNameValid &&
              isUsernameValid &&
              user.name?.length > 0 &&
              user.email?.length > 0 &&
              user.userName?.length > 0) {
            setState(() {
              page++;
            });
          } else {
            print('error');
            //TODO: Show dialog
          }
        },
        onBackButonPressed: () {
          setState(() {
            page--;
          });
        },
        onEmailChange: (value) {
          if (RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value)) {
            setState(() {
              isEmailValid = true;
              user.email = value;
            });
          } else {
            setState(() {
              isEmailValid = false;
            });
          }
        },
        onNameChange: (value) {
          if (value.trim().length == 0) {
            setState(() {
              isNameValid = false;
            });
          } else {
            setState(() {
              isNameValid = true;
            });
          }
          setState(() {
            user.name = value;
          });
        },
        onUsernameChange: (value) async {
          isUsernameAvailable = await Api.isUsernameAvailable(value);
          setState(() {
            user.userName = value;
          });
        },
      ),
      step2(
        networkImage: user.image,
        image: pickedImage,
        onRemoveImageButtonPressed: () {
          setState(() {
            pickedImage = null;
          });
        },
        onSelectImageButtonPressed: () async {
          XFile selectedImage =
              await picker.pickImage(source: ImageSource.gallery);
          var croppedFile = await ImageCropper.cropImage(
              sourcePath: selectedImage.path,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                // CropAspectRatioPreset.ratio3x2,
                // CropAspectRatioPreset.original,
                // CropAspectRatioPreset.ratio4x3,
                // CropAspectRatioPreset.ratio16x9
              ],
              androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: Theme.of(context).primaryColor,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: true),
              iosUiSettings: IOSUiSettings(
                minimumAspectRatio: 1.0,
              ));
          File compressedFile = await FlutterImageCompress.compressAndGetFile(
            croppedFile.path,
            '${Directory.systemTemp.path}/compressed.jpg',
            quality: 70,
          );

          // XFile(result.path);

          setState(() {
            if (compressedFile != null)
              pickedImage = XFile(compressedFile.path);
            selectedImage.length().then((value) => print(value));
            print(compressedFile.lengthSync());
          });
        },
        onBackButonPressed: () {
          setState(() {
            page--;
          });
        },
        primaryButtonOnPressed: () {
          setState(() {
            page++;
          });
        },
      ),
      step3(
        onSkillAdded: (skill) {
          setState(() {
            user.skills.add(skill);
          });
        },
        onSkillRemoved: (skill) {
          setState(() {
            user.skills.remove(skill);
          });
        },
        onBioChanged: (value) {
          setState(() {
            if (value.length < 100) {
              user.bio = value;
            }
          });
        },
        bioMax: 100,
        bioValue: user.bio,
        primaryButtonOnPressed: () async {
          if (widget.user == null) {
            var completed = await Api.postUser(user, pickedImage);
            if (completed) {
              setState(() {
                page++;
              });
              print('completee');
            } else {
              widget.onRegistrationError();
              print('error');
            }
          } else {
            var completed = await Api.putUser(user, pickedImage);
            if (completed) {
              setState(() {
                page++;
              });
              print('completee');
            } else {
              //widget.onRegistrationError();
              print('error');
            }
          }
        },
        onBackButonPressed: () {
          setState(() {
            page--;
          });
        },
      ),
      end(
        primaryButtonOnPressed: () {
          widget.onRegistrationComplete();
        },
      ),
    ];

    return Scaffold(
      key: Key('registration_Screen'),
      body: pages[page],
    );
  }
}

const isValidStep1 = {
  'email': true,
  'name': true,
  'username': true,
};
