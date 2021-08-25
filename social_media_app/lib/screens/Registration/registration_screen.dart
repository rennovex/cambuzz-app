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
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
                minWidth: double.infinity,
                maxHeight: double.infinity),
            child: Column(
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
                          child: screenMetaData,
                          width: MediaQuery.of(context).size.width * .9,
                        ),
                        bottom: bottomElementStackBottomPositioning,
                        top: topElementStackBottomPositioning,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: screenForm),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: PrimaryGradientButton(
                            onPressed: primaryButtonOnPressed,
                            text: primaryActionButtonText),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
