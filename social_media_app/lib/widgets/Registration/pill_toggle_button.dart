import 'package:flutter/material.dart';

class PillToggleButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const PillToggleButton(
      {Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.black)))),
          onPressed: this.onPressed,
          child: Container(
            child: Text(
              this.text,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          )),
    );
  }
}
