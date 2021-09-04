import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/widgets/primary_gradient_button.dart';

class RegistrationElement {
  final Widget topElement;
  final Widget bottomElement;
  double topElementStackBottomPositioning;
  double bottomElementStackBottomPositioning;
  final String primaryButtonText;
  final bool hasBackButton;
  final Function primaryButtonOnPressed;
  Function onBackButonPressed;
  RegistrationElement(
      {@required this.topElement,
      @required this.bottomElement,
      @required this.primaryButtonText,
      @required this.primaryButtonOnPressed,
      this.onBackButonPressed,
      this.hasBackButton = false,
      this.topElementStackBottomPositioning,
      this.bottomElementStackBottomPositioning});
  Widget get primaryActionButton {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        hasBackButton
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDF25FE),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      onBackButonPressed();
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )
            : Container(),
        Expanded(
          child: PrimaryGradientButton(
            onPressed: () {
              this.primaryButtonOnPressed();
            },
            text: this.primaryButtonText,
          ),
        ),
      ]),
    );
  }
}
