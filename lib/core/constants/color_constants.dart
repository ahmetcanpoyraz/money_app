import 'package:flutter/material.dart';

class ColorConstants {
  static final ColorConstants _instance = ColorConstants._init();
  static ColorConstants get instance => ColorConstants._instance;


  Color kBoldPink = const Color(0xffc0028b);
  Color kLightPink = const Color(0xfff9e6f3);
  Color kVeryLightPink = const Color(0xfff7f7f7);
  Color kWhite = const Color(0xffffffff);
  Color klightWhite = const Color(0xfff3f3f3);


  Color kOrange = Colors.orange;


  Color kBoldBlack = const Color(0xff18191a);
  Color kBlack = const Color(0xff242526);
  Color kLightBlack = const Color(0xff3a3b3c);
  Color kGray = const Color(0xffe4e6eb);
  Color kBoldGray = const Color(0xffb0b3b8);


  ColorConstants._init();
}
