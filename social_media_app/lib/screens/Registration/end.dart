import 'package:flutter/material.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class end extends StatelessWidget {
  final Function primaryButtonOnPressed;

  const end({
    Key key,
    @required this.primaryButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationScreenSkeleton(
      registrationElement: RegistrationElement(
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
          primaryButtonOnPressed: primaryButtonOnPressed),
    );
  }
}