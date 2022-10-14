// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  String? text;
  Function()? onPressed;
  Color? butonColor;
  CustomButton({
    Key? key,
    this.butonColor,
    this.onPressed,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: 60.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: butonColor, elevation: 0),
        onPressed: onPressed,
        child: Text(
          text!,
        ),
      ),
    );
  }
}
