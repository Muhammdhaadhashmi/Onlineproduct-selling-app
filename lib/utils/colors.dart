import 'package:flutter/material.dart';

const kPrimaryClr = Color(0xFF2cc660);
const kSecondarClr = Color(0xFF707070);
const kTextColor = Color(0xFF707070);
const kTextLightColor = Color(0xFF555555);
const kWhiteClr = Color(0xffffffff);
const kBlackClr = Color(0xff000000);
const kGreyClr = Color(0xffdcdcdc);
const primaryColor = kPrimaryClr;
const appButtonColor = Color(0xFFe3effe);
const defaultPrimaryColor = primaryColor;
const secondaryColor = Color(0xFF000000);
const scaffoldColorDark = Color(0xFF090909);
const appButtonColorDark = Color(0xFF282828);
const scaffoldSecondaryDark = Color(0xFF1E1E1E);
const kDefaultPadding = 20.0;

const kprimaryClr = Color(0xffFF5E00);
const kwhiteClr = kWhiteClr;
const kblackClr = kBlackClr;
const kgrayClr = Colors.grey;
const kgrayBgClr = Color.fromARGB(255, 217, 216, 216);
const kredClr = Colors.red;
const kgrayboxClr = Color(0xffF3F3F3);
const kgreenClr = Color(0xff32BFA6);

const kMaxWidth = 1232.0;
const kDefaultDuration = Duration(milliseconds: 250);

final kDefaultShadow = BoxShadow(
  offset: const Offset(0, 10),
  spreadRadius: 5,
  blurRadius: 20,
  color: const Color(0xFF0700B1).withOpacity(0.15),
);

// TextField dedign
final kDefaultInputDecorationTheme = InputDecorationTheme(
  border: kDefaultOutlineInputBorder,
  enabledBorder: kDefaultOutlineInputBorder,
  focusedBorder: kDefaultOutlineInputBorder,
);

// ignore: prefer_const_declarations
final kDefaultOutlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Color(0xFFCEE4FD),
  ),
);
