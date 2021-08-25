import 'package:flutter/material.dart';
import 'package:social_media_app/constants.dart';

class PillToggleButton extends StatefulWidget {
  final String text;
  var selected = false;
  final Function(bool) onPressed;

  PillToggleButton(
      {Key key, @required this.text, @required this.onPressed, this.selected})
      : super(key: key);

  @override
  _PillToggleButtonState createState() => _PillToggleButtonState();
}

class _PillToggleButtonState extends State<PillToggleButton> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: (widget.selected) ? kPrimaryColor : Colors.black)))),
          onPressed: () {
            setState(() {
              widget.selected = !widget.selected;
              (this.widget.onPressed ?? () {})(widget.selected);
            });
          },
          child: Container(
            child: Text(
              this.widget.text,
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 13,
                color: (widget.selected) ? kPrimaryColor : Colors.black,
              ),
            ),
          )),
    );
  }
}
