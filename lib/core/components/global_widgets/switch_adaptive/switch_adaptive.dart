
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchAdaptive extends StatelessWidget {
  final bool? value;
  final Function(bool)? onChange;


  const SwitchAdaptive(
      {Key? key,
        this.value,
        this.onChange,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 20.h,
      child: Switch.adaptive(
         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value ?? false,
        activeColor: Colors.green,
        onChanged: onChange
      ),
    );
  }
}
