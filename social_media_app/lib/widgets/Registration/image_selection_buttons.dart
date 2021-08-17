import 'package:flutter/material.dart';

class RemoveImageButton extends StatelessWidget {
  const RemoveImageButton({
    Key key,
    @required this.onRemoveImageButtonPressed,
  }) : super(key: key);

  final Function onRemoveImageButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onRemoveImageButtonPressed();
        },
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
        ));
  }
}

class SelectImageButton extends StatelessWidget {
  const SelectImageButton({
    Key key,
    @required this.onSelectImageButtonPressed,
  }) : super(key: key);

  final Function onSelectImageButtonPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onSelectImageButtonPressed();
      },
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
    );
  }
}