import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/widgets/primary_gradient_button.dart';

final user = {};

class RegistrationScreen extends StatelessWidget {
  final Widget screenMetaData;
  final Widget screenForm;
  final double bottomElementStackBottomPositioning;
  final double topElementStackBottomPositioning;
  final String primaryActionButtonText;
  final Function primaryButtonOnPressed;
  RegistrationScreen(
      {@required this.screenMetaData,
      @required this.screenForm,
      @required this.primaryActionButtonText,
      @required this.primaryButtonOnPressed,
      this.bottomElementStackBottomPositioning = 0,
      this.topElementStackBottomPositioning = 0});

  @override
  Widget build(BuildContext context) {
    print('primary button Text = ' + primaryActionButtonText);
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                          SvgPicture.asset(
                            'images/registration_background.svg',
                            width: MediaQuery.of(context).size.width,
                          ),
                        Positioned(
                          child: SafeArea(
                            child: Container(
                              child: screenMetaData,
                              width: MediaQuery.of(context).size.width * .9,
                            ),
                          ),
                          bottom: bottomElementStackBottomPositioning,
                          top: topElementStackBottomPositioning,
                        )
                      ],
                    ),
                    // Spacer(),
                    Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: screenForm),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: PrimaryGradientButton(
                  onPressed: primaryButtonOnPressed,
                  text: primaryActionButtonText),
            )
          ],
        ),
      ),
    );
  }
}
