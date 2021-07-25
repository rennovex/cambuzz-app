import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/primary_gradient_button.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';

int page = 0;
final pages = [intro, step1, step2, step3, end];

final user = {};

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    pages[page].pageChange = () {
      print('page changing');
      setState(() {});
    };
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RegistrationScreenSkeleton(
        registrationElement: pages[page], //change to step 1 and step 2 here
      ),
    );
  }
}

RegistrationElement intro = new RegistrationElement(
    primaryButtonOnPressed: () {
      page++;
    },
    bottomElementStackBottomPositioning: -160,
    topElement: Image.asset('images/cambuzz_icon.png'),
    bottomElement: Container(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Cambuzz',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: 'Poppins',
              fontSize: 36,
            ),
          ),
          Text(
            'For TKM',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
            ),
          ),
          Text(
            'Bringing Together smart people from tkm',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Color(0xff2f005f),
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
    primaryButtonText: 'Aight, now log me in!');

RegistrationElement step1 = new RegistrationElement(
    topElementStackBottomPositioning: 50,
    topElement: RegistrationStepTop(
      header: "Let’s get you set up and running!",
      step: 1,
    ),
    bottomElement: Container(
      child: Column(
        children: [
          LabelledTextField(
            labelText: 'Email',
          ),
          LabelledTextField(labelText: 'Name'),
          LabelledTextField(labelText: 'Username'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('available', style: TextStyle(color: Colors.green)),
              Icon(
                Icons.done,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    ),
    primaryButtonText: "Let's set your dp >",
    primaryButtonOnPressed: () {
      page++;
    },
    onBackButonPressed: () {
      page--;
    },
    hasBackButton: true);

RegistrationElement step2 = new RegistrationElement(
  topElementStackBottomPositioning: 50,
  topElement: RegistrationStepTop(
    header: "Let’s add your profile image!",
    step: 2,
  ),
  bottomElement: Container(
    child: Column(children: [
      SizedBox(
        height: 30,
      ),
      CircleAvatar(
        radius: 100,
        backgroundImage: NetworkImage('https://picsum.photos/200'),
      ),
      SizedBox(height: 30),
      Container(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Select an image',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Color(0xff00BF2A),
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  'Remove selected',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Poppins', fontSize: 14),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color(0xffFF4444),
                  ),
                ))
          ],
        ),
      )
    ]),
  ),
  primaryButtonText: "Let's set your bio >",
  primaryButtonOnPressed: () {
    page++;
  },
  hasBackButton: true,
  onBackButonPressed: () {
    page--;
  },
);

RegistrationElement step3 = new RegistrationElement(
    topElementStackBottomPositioning: 50,
    topElement: RegistrationStepTop(
      header: "Let’s add your Bio!",
      step: 3,
    ),
    bottomElement: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            LabelledTextField(
              labelText: 'Bio',
              inputType: TextInputType.multiline,
              maxLines: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [Text('0/100')],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Skills',
                  style: TextStyle(
                      fontFamily: 'poppins', fontWeight: FontWeight.w800),
                ),
                SingleChildScrollView(
                  child: Wrap(
                    children: [
                      PillToggleButton(text: 'Programmer'),
                      PillToggleButton(text: 'Web Developer'),
                      PillToggleButton(text: 'App Developer'),
                      PillToggleButton(text: 'Content creator'),
                      PillToggleButton(text: 'Singer'),
                      PillToggleButton(text: 'Dancer'),
                      PillToggleButton(text: 'Mechanic'),
                      PillToggleButton(text: 'Artist'),
                      PillToggleButton(text: 'Entrepreneur'),
                      PillToggleButton(text: 'Entrepreneur'),
                      PillToggleButton(text: 'Entrepreneur'),
                      PillToggleButton(text: 'Entrepreneur'),
                      PillToggleButton(text: 'Entrepreneur'),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
    primaryButtonText: "Finish",
    primaryButtonOnPressed: () {
      page ++;
    },
    onBackButonPressed: (){
      page--;
    },
    hasBackButton: true);

RegistrationElement end = new RegistrationElement(
    topElementStackBottomPositioning: 50,
    topElement: RegistrationStepTop(
      header: "Hurray!",
    ),
    bottomElement: Container(
      child: Column(
        children: [
          Image.asset('images/success.png'),
          Text(
            "You're ready \n to rock n roll!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff53138C),
              fontSize: 33,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    ),
    primaryButtonText: "Let's gooooooooo >",
    primaryButtonOnPressed: () {});
