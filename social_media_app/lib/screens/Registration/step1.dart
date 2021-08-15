import 'package:flutter/material.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class Step1 extends StatefulWidget {
  Function onUsernameChange;
  String username;
  String email;
  Function onEmailChange;
  Function onNameChange;
  String name;
  Function onPrimaryButtonPressed;

  Step1(
      {this.email = '',
      this.username = '',
      this.name = '',
      this.onUsernameChange,
      this.onEmailChange,
      this.onPrimaryButtonPressed,
      this.onNameChange});

  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  bool isUsernameAvailable = true;

  bool emailIsValid = true;

  bool nameIsValid = true;

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      primaryButtonOnPressed: () {
        widget.onPrimaryButtonPressed!=null?widget.onPrimaryButtonPressed():'';
        Navigator.of(context).pop({'name':widget.name, 'email':widget.email, 'username':widget.username});
      },
      primaryActionButtonText: "Let's set your dp >",
      screenMetaData: RegistrationStepTop(
        header: "Let’s get you set up and running!",
        step: 1,
      ),
      screenForm: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LabelledTextField(
                labelText: 'Username',
                onChanged: (value) async {
                  (widget.onUsernameChange!=null)?widget.onUsernameChange(value):'';
                  isUsernameAvailable = await Api.isUsernameAvailable(value);
                  setState(() {
                    widget.username=value;
                  });
                },
                value: widget.username,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text((isUsernameAvailable) ? 'available' : 'taken',
                      style: TextStyle(
                          color: (isUsernameAvailable)
                              ? Colors.green
                              : Colors.red)),
                  Icon(
                    (isUsernameAvailable) ? Icons.done : Icons.error,
                    color: (isUsernameAvailable) ? Colors.green : Colors.red,
                  ),
                ],
              ),
              LabelledTextField(
                isDisabled: true,
                labelText: 'Email',
                value: widget.email,
                onChanged: widget.onEmailChange,
                inputType: TextInputType.emailAddress,
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
                onChanged: (value){
                  widget.onNameChange!=null?widget.onNameChange(value):'';
                  setState(() {
                    widget.name = value;
                  });
                },
                
                value: widget.name,
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
            ],
          ),
        ),
      ),
    );
  }
}
