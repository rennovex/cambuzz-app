import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/models/registration_widget_element.dart';

class RegistrationScreenSkeleton extends StatelessWidget {
  final RegistrationElement registrationElement;
  const RegistrationScreenSkeleton(
      {Key key, @required this.registrationElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Positioned(
                child: SvgPicture.asset(
                  'images/registration_background.svg',
                ),
              ),
              Positioned(
                child: Container(
                  child: registrationElement.topElement,
                  width: MediaQuery.of(context).size.width * .9,
                ),
                bottom: registrationElement.bottomElementStackBottomPositioning,
                top: registrationElement.topElementStackBottomPositioning,
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width * .9,
                child: registrationElement.bottomElement)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Container(width: MediaQuery.of(context).size.width*.8,child: registrationElement.primaryActionButton))
      ],
    );
  }
}
