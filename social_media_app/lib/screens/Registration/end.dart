import 'package:flutter/material.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class End extends StatelessWidget {
  Function primaryButtonOnPressed;
  End({this.primaryButtonOnPressed});

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(screenMetaData: RegistrationStepTop(
            header: "Hurray!",
          ), screenForm: SingleChildScrollView(
            child: Container(
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
          ), primaryActionButtonText: "Let's gooooooooo >", primaryButtonOnPressed: primaryButtonOnPressed,topElementStackBottomPositioning: 50);
  }
}
