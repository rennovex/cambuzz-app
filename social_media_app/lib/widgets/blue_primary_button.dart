import 'package:flutter/material.dart';

class BluePrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const BluePrimaryButton({
    this.onPressed,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff4553F3))),
      child: Text(text, style: TextStyle(color: Colors.white)),
      onPressed:onPressed,
    );
  }
}
