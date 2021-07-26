import 'package:flutter/material.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/Registration/end.dart';
import 'package:social_media_app/screens/Registration/intro.dart';
import 'package:social_media_app/screens/Registration/step1.dart';
import 'package:social_media_app/screens/Registration/step2.dart';
import 'package:social_media_app/screens/Registration/step3.dart';

final user = {};

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var user = User(userName: '', name: '', email: '',skills: []);

  var isNameValid = true;
  var isUsernameValid = true;
  var isEmailValid = true;

  List<Widget> pages;
  int page = 0;

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
        emailIsValid: isEmailValid,
        nameIsValid: isNameValid,
        usernameIsValid: isUsernameValid,
        nameValue: user.name,
        emailValue: user.email,
        usernameValue: user.userName,
        primaryButtonOnPressed: () {
          setState(() {
            page++;
          });
          // if (isEmailValid && isNameValid && isUsernameValid && user.name?.length>0 && user.email?.length>0  && user.userName?.length>0) {
          //   setState(() {
          //     page++;
          //   });
          // }else{
          //   print('error');
          //   //TODO: Show dialog
          // }
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
        onUsernameChange: (value) {
          setState(() {
            user.userName = value;
          });
        },
      ),
      step2(
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
        skills: ['Programmer','Web Developer','App Developer','Content creator','Singer','Dancer','Mechanic','Artist','Entrepreneur'],
        onSkillAdded: (skill){
          setState(() {
            user.skills.add(skill);
          });
        },
        onSkillRemoved: (skill){
          setState(() {
            user.skills.remove(skill);
          });
        },
        onBioChanged: (value){
          setState(() {
            if(value.length<100){
              user.bio = value;
            }
          });
        },
        bioMax: 100,
        bioValue: user.bio,
        primaryButtonOnPressed: () {
          setState(() {
            page++;
          });
        },
        onBackButonPressed: () {
          setState(() {
            page--;
          });
        },
      ),
      end(
        primaryButtonOnPressed: () {
          print([user.userName, user.email, user.name, user.bio, user.skills]);
        },
      ),
    ];

    return Scaffold(
      key: Key('registration_Screen'),
      resizeToAvoidBottomInset: false,
      body: pages[page],
    );
  }
}

const isValidStep1 = {
  'email': true,
  'name': true,
  'username': true,
};
