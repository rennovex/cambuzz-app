import 'package:flutter/material.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';


class step2 extends StatelessWidget {
  final Function primaryButtonOnPressed;
  final Function onBackButonPressed;

  const step2({
    Key key,
    @required this.onBackButonPressed,
    @required this.primaryButtonOnPressed,
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
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 14),
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
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 14),
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
        primaryButtonOnPressed: primaryButtonOnPressed,
        hasBackButton: true,
        onBackButonPressed: onBackButonPressed,
      ),
    );
  }
}