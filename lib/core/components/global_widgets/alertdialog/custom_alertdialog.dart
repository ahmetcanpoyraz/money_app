// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAlertDialog extends StatelessWidget {
  final Color? bgColor;
  final String? title;
  final Color? titleColor;
  final String? message;
  final String? butonText;
  final Color? butonColor;
  Function()? onButtonPressed;

  CustomAlertDialog(
      {Key? key,
      this.title,
      this.titleColor,
      this.message,
      this.bgColor = Colors.white,
      this.butonText,
      this.butonColor,
      this.onButtonPressed,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title!,style: GoogleFonts.montserrat(color: titleColor,fontSize: 20.sp,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
      content:
          Text(
              message!,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 16.sp ),
            ),
      contentPadding: EdgeInsets.all(45.sp),
      backgroundColor: bgColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        SizedBox(
          width: 200.w,
          height: 60.h,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: butonColor,
                  elevation: 0
              ),
              onPressed: onButtonPressed!,
              child: Text(butonText!)),
        ),
      ],
    );
  }
}
