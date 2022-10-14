import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final Color? lineColor;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final bool? showLine;
  final TextAlign? textAlign;

  const CustomTextFormField(
      {Key? key,
        this.textAlign,
        this.showLine,
        this.controller,
        this.textStyle,
        this.lineColor,
        this.inputFormatter,
        this.textInputType,
        this.validator,
        this.focusNode,
        this.contentPadding,
        this.onTap,
       })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
         enabledBorder: UnderlineInputBorder(
              borderSide: showLine != null ? BorderSide(color: lineColor!) : BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
           borderSide: showLine != null ?  BorderSide(color: lineColor!,width: 2.w) : BorderSide.none,
        ),

      ),
      enableInteractiveSelection: false,
      focusNode: focusNode,
      inputFormatters: inputFormatter,
      keyboardType: textInputType,
      cursorColor: lineColor,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      style: textStyle,
      validator: validator,
      onTap: onTap,
    );
  }
}
