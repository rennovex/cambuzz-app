import 'package:flutter/material.dart';

class PrimaryGradientButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const PrimaryGradientButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: LinearGradient(
            colors: [Color(0xffDF25FE), Color(0xff5025FE)],
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
