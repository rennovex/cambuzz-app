import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/Registration/image_selection_buttons.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';


class step2 extends StatelessWidget {
  final Function primaryButtonOnPressed;
  final Function onBackButonPressed;
  final Function onSelectImageButtonPressed;
  final Function onRemoveImageButtonPressed;
  final XFile image;

  const step2({
    Key key,
    @required this.image,
    @required this.onBackButonPressed,
    @required this.primaryButtonOnPressed,
    @required this.onRemoveImageButtonPressed,
    @required this.onSelectImageButtonPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationScreenSkeleton(
      registrationElement: RegistrationElement(
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
              backgroundImage:(image==null)?NetworkImage('https://picsum.photos/200'):FileImage(File(image.path)),
            ),
            SizedBox(height: 30),
            Container(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SelectImageButton(onSelectImageButtonPressed: onSelectImageButtonPressed),
                  RemoveImageButton(onRemoveImageButtonPressed: onRemoveImageButtonPressed)
                ],
              ),
            )
          ]),
        ),
        primaryButtonText: "Let's set your bio >",
        primaryButtonOnPressed: primaryButtonOnPressed,
        hasBackButton: true,
        onBackButonPressed: onBackButonPressed,
      ),
    );
  }
}
