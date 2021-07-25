import 'package:flutter/material.dart';

class LabelledTextField extends StatelessWidget {
  final String labelText;
  const LabelledTextField({Key key, @required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style:
                TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w800),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(6),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
