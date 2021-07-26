import 'package:flutter/material.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class step1 extends StatelessWidget {
  final Function primaryButtonOnPressed;
  final Function onBackButonPressed;
  final Function(String) onEmailChange;
  final Function(String) onNameChange;
  final Function(String) onUsernameChange;
  String emailValue;
  String nameValue;
  String usernameValue;
  bool emailIsValid;
  bool nameIsValid;
  bool usernameIsValid;

  step1(
      {Key key,
      @required this.onBackButonPressed,
      @required this.primaryButtonOnPressed,
      @required this.onEmailChange,
      @required this.onNameChange,
      @required this.onUsernameChange,
      this.emailValue,
      this.emailIsValid,
      this.nameIsValid,
      this.nameValue,
      this.usernameIsValid,
      this.usernameValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationScreenSkeleton(
      registrationElement: RegistrationElement(
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
                  onChanged: onEmailChange,
                  inputType: TextInputType.emailAddress,
                  value: emailValue,
                ),
                (!emailIsValid)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'email not valid',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : Container(),
                LabelledTextField(
                  labelText: 'Name',
                  onChanged: onNameChange,
                  value: nameValue,
                ),
                (!nameIsValid)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'name not valid',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : Container(),
                LabelledTextField(
                  labelText: 'Username',
                  onChanged: onUsernameChange,
                  value: usernameValue,
                ),
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
          primaryButtonOnPressed: primaryButtonOnPressed,
          onBackButonPressed: onBackButonPressed,
          hasBackButton: true),
    );
  }
}
