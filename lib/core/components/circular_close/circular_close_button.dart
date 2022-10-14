// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../init/navigation/navigation_service.dart';

class CircularCloseButton extends StatelessWidget {

  CircularCloseButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        NavigationService.instance.popPage();
      },
      child: Padding(
        padding:  EdgeInsets.all(12.0.h),
        child: Container(
            decoration:  BoxDecoration(
                color: Theme.of(context).backgroundColor,
                shape: BoxShape.circle
            ),
            child: Padding(
              padding:  EdgeInsets.all(2.h),
              child: Icon(Icons.close,
                color: Theme.of(context).primaryColor,),
            )),
      ),);
  }
}
