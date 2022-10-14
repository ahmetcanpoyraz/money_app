
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/core/components/global_widgets/switch_adaptive/switch_adaptive.dart';

class TextWithSwitchAdaptive extends StatelessWidget {
  final bool? value;
  final Function(bool)? onChange;
  final Color? backgroundColor;
  final Widget textWidget;
  final EdgeInsetsGeometry? edgeInsetsGeometry;


  const TextWithSwitchAdaptive(
      {Key? key,
        this.edgeInsetsGeometry,
        required this.textWidget,
        this.backgroundColor,
        this.value,
        this.onChange,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: backgroundColor,
      width: double.infinity,
      child:Padding(
          padding: edgeInsetsGeometry!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget,
              SwitchAdaptive(value: value,onChange: onChange,)
            ],
          )
      )
      ,);
  }
}
