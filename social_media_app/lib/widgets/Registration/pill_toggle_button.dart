import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class PillToggleButton extends StatefulWidget {
  final String text;
  final Function(bool) onPressed;

  const PillToggleButton(
      {Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  _PillToggleButtonState createState() => _PillToggleButtonState();
}

class _PillToggleButtonState extends State<PillToggleButton> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: (selected) ? kPrimaryColor : Colors.black)))),
          onPressed: () {
            setState(() {
              selected = !selected;
              (this.widget.onPressed ?? () {})(selected);
            });
          },
          child: Container(
            child: Text(
              this.widget.text,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 13,
                color: (selected) ? kPrimaryColor : Colors.black,
              ),
            ),
          )),
    );
  }
}
