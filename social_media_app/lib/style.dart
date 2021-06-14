import 'package:flutter/material.dart';

const LargeTextSize = 18.0;
const MediumTextSize = 17.0;
const SmallTextSize = 16.0;
const BodyTextSize = 16.0;

const String FontNamePrimary = '';

const TitleTextStyle = TextStyle(
  fontFamily: FontNamePrimary,
  fontWeight: FontWeight.bold,
  fontSize: LargeTextSize,
  color: Colors.white,
);
const SubtitleTextStyle = TextStyle(
  fontFamily: FontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: LargeTextSize,
  color: Colors.white,
);
const BodyprimaryTextStyle = TextStyle(
  fontFamily: FontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: LargeTextSize,
  color: Colors.white,
);
const BodySecondaryTextStyle = TextStyle(
  fontFamily: FontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: LargeTextSize,
  color: Colors.white,
);

const AppBarBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30)),
    color: Color.fromRGBO(28, 28, 28, 1),
  );