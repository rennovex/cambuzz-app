import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/primary_gradient_button.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';





class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RegistrationScreenSkeleton(
        registrationElement: intro, //change to step 1 and step 2 here
      ),
    );
  }
}
