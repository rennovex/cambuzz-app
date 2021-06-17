import 'package:flutter/material.dart';

const kLargeTextSize = 18.0;
const kMediumTextSize = 17.0;
const kSmallTextSize = 16.0;
const kBodyTextSize = 16.0;

const Color kPrimaryColor = Color.fromRGBO(98, 65, 234, 1);
const Color kSecondaryColor = Color.fromRGBO(69, 83, 243, 1);
const Color kGradientStartColor = Color.fromRGBO(98, 65, 234, 1);
const Color kGradientEndColor = Color.fromRGBO(219, 0, 255, 1);

const LinearGradient kLinearGradient = LinearGradient(
  colors: [
    kGradientStartColor,
    kGradientEndColor,
  ],
);

const LinearGradient kButtonLinearGradient = LinearGradient(
  colors: [
    Color.fromRGBO(147, 33, 218, 1),
    Color.fromRGBO(30, 107, 255, 1),
  ],
);

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
    bottomRight: Radius.circular(30),
  ),
  color: Color.fromRGBO(28, 28, 28, 1),
);

const kPostBottomMetricTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

const kPostHeaderTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  fontSize: 17,
);

const kPostSubHeaderTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

const kPostTimeTextStyle = TextStyle(
  fontFamily: 'Poppins',
);

const kPostTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

// Profile

const kProfilePicRadius = 40.0;

const kProfileButtonText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kProfileName = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16,
  fontWeight: FontWeight.w800,
);

const kProfileLabel = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 12,
  fontWeight: FontWeight.w700,
);

const kProfileTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

// Trending
//  User
const kTrendingJoinButton = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kTrendingUserName = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: 7,
);

const kTrendingUserText = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 7,
);

//  Community

const kTrendingCommunityName = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  color: Colors.white,
  fontSize: 15,
);

const kTrendingCommunityTitle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(203, 203, 203, 1),
  fontSize: 11,
);

const kTrendingCommunityBody = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(203, 203, 203, 1),
  fontSize: 12,
  height: 1.2,
);

const kTrendingCommunityContent = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 12,
  height: 1.2,
);

const kTrendingCommunityLikes = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  color: Colors.red,
  fontSize: 14,
);
