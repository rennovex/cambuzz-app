import 'package:flutter/material.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';
import 'package:social_media_app/widgets/primary_gradient_button.dart';

class RegistrationElement {
  final Widget topElement;
  final Widget bottomElement;
  double topElementStackBottomPositioning;
  double bottomElementStackBottomPositioning;
  final String primaryButtonText;
  final bool hasBackButton;
  final Function primaryButtonOnPressed;
  RegistrationElement(
      {@required this.topElement,
      @required this.bottomElement,
      @required this.primaryButtonText,
      @required this.primaryButtonOnPressed,
      this.hasBackButton = false,
      this.topElementStackBottomPositioning,
      this.bottomElementStackBottomPositioning});
  Widget get primaryActionButton {
    return PrimaryGradientButton(
      onPressed: this.primaryButtonOnPressed,
      text: this.primaryButtonText,
    );
  }
}

RegistrationElement intro = new RegistrationElement(
    primaryButtonOnPressed: () {},
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
    primaryButtonText: "Let's set your profile image >",
    primaryButtonOnPressed: () {});

RegistrationElement step2 = new RegistrationElement(
    topElementStackBottomPositioning: 50,
    topElement: RegistrationStepTop(
      header: "Let’s add your profile image!",
      step: 2,
    ),
    bottomElement: Container(
      child: Column(
        children: [
          
        ]
      ),
    ),
    primaryButtonText: "Let's set your bio >",
    primaryButtonOnPressed: () {});
