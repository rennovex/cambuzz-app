import 'package:flutter/material.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';

class Intro extends StatelessWidget {
  final Function primaryButtonOnPressed;
  Intro({Key key, @required this.primaryButtonOnPressed}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      screenMetaData: Image.asset('images/cambuzz_icon.png', width: 200,),
      screenForm: Container(
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
      primaryActionButtonText: 'Aight, now log me in!',
      bottomElementStackBottomPositioning: -160,
      primaryButtonOnPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.login();
        //TODO: check here
        //Navigator.of(context).pop();
        primaryButtonOnPressed();
      },
    );
  }
}
