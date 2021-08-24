import 'package:flutter/material.dart';

const kLargeTextSize = 18.0;
const kMediumTextSize = 17.0;
const kSmallTextSize = 16.0;
const kBodyTextSize = 16.0;

const kAppBarPreferredSize = Size.fromHeight(60);

const Color kAppBarPrimaryColor = Color.fromRGBO(28, 28, 28, 1);

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

const String kFontNamePrimary = 'Lato';

const kAppBarTitleStyle = TextStyle(
  fontFamily: 'Billabong',
  // fontWeight: FontWeight.normal,
  fontSize: 30,
  color: Colors.white,
);

const kTitleTextStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w900,
  fontSize: kLargeTextSize,
  color: Colors.black,
);

const kSubtitleTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.normal,
  fontSize: kSmallTextSize,
  color: Colors.black,
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
  fontFamily: kFontNamePrimary,
);

const kPostHeaderTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w900,
  fontSize: 18,
);

const kPostSubHeaderTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
);

const kPostTimeTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
);

const kPostTitleTextStyle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);

// Profile

const kProfilePicRadius = 40.0;

const kProfileButtonText = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kProfileName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 16,
  fontWeight: FontWeight.w800,
);

const kProfileLabel = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 12,
  fontWeight: FontWeight.w700,
);

const kProfileTitle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 13,
  fontWeight: FontWeight.w600,
);

// Trending
//  User
const kTrendingJoinButton = TextStyle(
  fontFamily: kFontNamePrimary,
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kTrendingUserName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: 11,
  shadows: <Shadow>[
    Shadow(
      blurRadius: 5.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ],
);

const kTrendingUserText = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 7,
);

const kTrendingUserRankingText = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: 11,
);

//  Community

const kTrendingCommunityName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w700,
  color: Colors.white,
  fontSize: 15,
);

const kTrendingCommunityTitle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(203, 203, 203, 1),
  fontSize: 11,
);

const kTrendingCommunityBody = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  color: Color.fromRGBO(203, 203, 203, 1),
  fontSize: 12,
  height: 1.2,
);

const kTrendingCommunityContent = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 12,
  height: 1.2,
);

const kTrendingCommunityLikes = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w400,
  color: Colors.red,
  fontSize: 14,
);

//  Events

const kEventCommunityName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w800,
  color: Colors.black,
  fontSize: 18,
);

const kEventHeader = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 15,
);

const kEventBody = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  // height: 1.5,
  color: Colors.black,
  fontSize: 12,
);

const kEventBadge = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontSize: 12,
);

const kEventMonth = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w800,
  color: Colors.black,
  fontSize: 14,
);

const kEventDate = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w900,
  color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 24,
);

const kEventTime = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 12,
);

//  EventExpanded

const kEventExpandedDay = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w900,
  color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 30,
);

const kEventExpandedMonth = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w800,
  // color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 18,
);

const kEventExpandedTime = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w700,
  // color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 16,
);
const kEventExpandedName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w900,
  // color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 24,
);
const kEventExpandedCommunityName = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w800,
  // color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 18,
);

const kEventExpandedDescription = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w500,
  // color: Color.fromRGBO(35, 105, 254, 1),
  fontSize: 14,
);

// Search

const kSearchTitle = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  fontSize: 18,
);
const kSearchFilterText = TextStyle(
  fontFamily: kFontNamePrimary,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontSize: 13,
);
