// ignore_for_file: must_be_immutable
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../views/transactions/transactions_viewmodel.dart';
import '../../constants/assets_constants.dart';

class ChangeLangWidget extends StatelessWidget {

  ChangeLangWidget({
    Key? key,
  }) : super(key: key);

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "en", child: SvgPicture.asset(AssetPath.uk_flag,width: 30.w,height: 40.h,)),
      DropdownMenuItem(value: "tr", child: SvgPicture.asset(AssetPath.tr_flag,width: 30.w,height: 40.h,)),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(left: 10.w),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            iconSize: 0,
            dropdownWidth: 80.w,
            hint: Icon(Icons.language,size: 24.h,),
            items: dropdownItems,
            onChanged: (value) async {
              Provider.of<TransactionsViewModel>(context,listen: false).changeSelectedValue(value.toString());
            },
            buttonHeight: 80.h,
            buttonWidth: 80.w,
            itemHeight: 50.h,

          ),
        ));
  }
}
