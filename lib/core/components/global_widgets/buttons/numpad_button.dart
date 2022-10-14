// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumPadButton extends StatelessWidget {
  Function()? onPressed;
  Widget? child;
  NumPadButton({
    Key? key,
    this.child,
    this.onPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
        surfaceTintColor: Theme.of(context).primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ), onPressed: onPressed,
      child: SizedBox(child: Center(child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 10.h),
        child: child,
      ))),
    );
  }
}

