import 'package:flutter/material.dart';

const kLargeTextSize = 18.0;
const kMediumTextSize = 17.0;
const kSmallTextSize = 16.0;
const kBodyTextSize = 16.0;

const String kFontNamePrimary = '';

const kTitleTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.bold,
  fontSize: kLargeTextSize,
  color: Colors.white,
);
const kSubtitleTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: kLargeTextSize,
  color: Colors.white,
);
const kBodyprimaryTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: kLargeTextSize,
  color: Colors.white,
);
const kBodySecondaryTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: kLargeTextSize,
  color: Colors.white,
  
);

const kAppBarBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30)),
    color: Color.fromRGBO(28, 28, 28, 1),
);