import 'package:flutter/material.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/providers/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class intro extends StatelessWidget {
  final Function primaryButtonOnPressed;
  intro({Key key, @required this.primaryButtonOnPressed}) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return RegistrationScreenSkeleton(
      registrationElement: RegistrationElement(
          primaryButtonOnPressed: (){
            final provider = Provider.of<GoogleSignInProvider>(context, listen:false);
            provider.login();
            primaryButtonOnPressed();
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
          primaryButtonText: 'Aight, now log me in!'),
    );
  }
}
