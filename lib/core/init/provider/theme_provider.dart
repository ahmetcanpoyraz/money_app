import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/color_constants.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

String fontFamily = GoogleFonts.montserrat().fontFamily!;



class MyThemes {
  static final lightTheme = ThemeData(
    fontFamily: fontFamily,
    primaryColor: ColorConstants.instance.kBoldPink,
    backgroundColor: ColorConstants.instance.kWhite,
    secondaryHeaderColor: ColorConstants.instance.kVeryLightPink,
    scaffoldBackgroundColor: ColorConstants.instance.klightWhite,
    shadowColor: ColorConstants.instance.kBoldGray,
    hoverColor: ColorConstants.instance.kBoldBlack,



    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        fontSize: 50.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      headline2: GoogleFonts.montserrat(
        fontSize: 25.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      headline3: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      button: GoogleFonts.montserrat(
        fontSize: 18.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: GoogleFonts.montserrat(
        fontSize: 12.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: GoogleFonts.montserrat(
        fontSize: 14.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w600,
      ),
      headline4: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w300,
      ),
      headline5: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kBoldPink,
        fontWeight: FontWeight.w300,
      ),
      headline6: GoogleFonts.montserrat(
        fontSize: 70.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: GoogleFonts.montserrat(
        fontSize: 10.sp,
        color: ColorConstants.instance.kBoldGray,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: GoogleFonts.montserrat(
        fontSize: 37.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w300,
      ),
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 23.33.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 26.91.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w300,
      ),
      // headline5: TextStyle(
      //   fontSize: 12.sp,
      //   color: AppColors.emperor,
      //   fontWeight: FontWeight.w400,
      //   //height: 1.9.sp,
      // ),
      // headline6: TextStyle(
      //   fontSize: 10.sp,
      //   color: AppColors.silver,
      //   fontWeight: FontWeight.w400,
      //   // height: 1.2.sp,
      // ),
    ),
  );

  static final darkTheme = ThemeData(
    fontFamily: fontFamily,
    primaryColor: ColorConstants.instance.kOrange,
    backgroundColor: ColorConstants.instance.kWhite,
    secondaryHeaderColor: ColorConstants.instance.kVeryLightPink,
    scaffoldBackgroundColor: ColorConstants.instance.klightWhite,
    shadowColor: ColorConstants.instance.kBoldGray,
    hoverColor: ColorConstants.instance.kBoldBlack,



    textTheme: TextTheme(
      headline1: GoogleFonts.montserrat(
        fontSize: 50.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      headline2: GoogleFonts.montserrat(
        fontSize: 25.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      headline3: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      button: GoogleFonts.montserrat(
        fontSize: 18.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: GoogleFonts.montserrat(
        fontSize: 12.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w500,
      ),
      bodyText2: GoogleFonts.montserrat(
        fontSize: 14.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w600,
      ),
      headline4: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kBlack,
        fontWeight: FontWeight.w300,
      ),
      headline5: GoogleFonts.montserrat(
        fontSize: 16.sp,
        color: ColorConstants.instance.kBoldPink,
        fontWeight: FontWeight.w300,
      ),
      headline6: GoogleFonts.montserrat(
        fontSize: 70.sp,
        color: ColorConstants.instance.kWhite,
        fontWeight: FontWeight.w600,
      ),
      subtitle2: GoogleFonts.montserrat(
        fontSize: 10.sp,
        color: ColorConstants.instance.kBoldGray,
        fontWeight: FontWeight.w600,
      ),
      subtitle1: GoogleFonts.montserrat(
        fontSize: 37.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w300,
      ),
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 23.33.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 26.91.sp,
        color: ColorConstants.instance.kBoldBlack,
        fontWeight: FontWeight.w300,
      ),
      // headline5: TextStyle(
      //   fontSize: 12.sp,
      //   color: AppColors.emperor,
      //   fontWeight: FontWeight.w400,
      //   //height: 1.9.sp,
      // ),
      // headline6: TextStyle(
      //   fontSize: 10.sp,
      //   color: AppColors.silver,
      //   fontWeight: FontWeight.w400,
      //   // height: 1.2.sp,
      // ),
    ),
  );
}
