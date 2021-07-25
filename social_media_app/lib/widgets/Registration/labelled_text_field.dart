import 'package:flutter/material.dart';

class LabelledTextField extends StatelessWidget {
  final String labelText;
  final TextInputType inputType;
  final int maxLines;
  const LabelledTextField({Key key, @required this.labelText,this.maxLines=1, this.inputType=TextInputType.text})
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
          Container(
            child: TextField(
              keyboardType: inputType,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
