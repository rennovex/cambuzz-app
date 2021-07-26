import 'package:flutter/material.dart';

class LabelledTextField extends StatefulWidget {
  final String labelText;
  final TextInputType inputType;
  final int maxLines;
  final Function(String) onChanged;
  Function() onEditingComplete;
  Function(String) onSubmitted;
  final String value;

  LabelledTextField({
    Key key,
    this.onSubmitted,
    this.onEditingComplete,
    @required this.onChanged,
    @required this.labelText,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.value=''
  }) : super(key: key);

  @override
  _LabelledTextFieldState createState() => _LabelledTextFieldState();
}

class _LabelledTextFieldState extends State<LabelledTextField> {
  TextEditingController valueContoller;


  @override
  void initState() {
    super.initState();
    valueContoller = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    valueContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style:
                TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w800),
          ),
          Container(
            child: TextField(
              controller: valueContoller,
              onEditingComplete: widget.onEditingComplete,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              keyboardType: widget.inputType,
              maxLines: widget.maxLines,
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
