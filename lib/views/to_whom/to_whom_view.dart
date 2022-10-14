// ignore_for_file: unnecessary_null_comparison
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/core/components/global_widgets/buttons/button.dart';
import 'package:money_app/views/to_whom/to_whom_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/components/global_widgets/appBar/custom_app_bar.dart';
import '../../core/components/global_widgets/customTextFormField/custom_text_form_field.dart';

class ToWhomView extends StatelessWidget {
  const ToWhomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ToWhomViewModel>(
      viewModel: Provider.of<ToWhomViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      portraitOnPageBuilder: (context, viewModel, _) => Scaffold(
          appBar: AppBarCustom(title: "appName".tr(), showBackButton: false,showCircularCloseButton: true,),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 81.h),
                    child: Center(
                        child: Text(
                      "toWhom".tr(),
                      style: Theme.of(context).textTheme.headline2,
                    )),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 44.w, vertical: 95.h),
                      child: CustomTextFormField(
                        inputFormatter: [LengthLimitingTextInputFormatter(18)],
                        showLine: true,
                        textAlign: TextAlign.center,
                        controller: viewModel.textEditingController,
                        textStyle: Theme.of(context).textTheme.headline2,
                        lineColor: Theme.of(context).backgroundColor,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 25.h),
                    child: CustomButton(
                      butonColor: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.5),
                      text: "pay".tr(),
                      onPressed: () {
                        viewModel.onPayButtonPress();
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
      landscapeOnPageBuilder: (context, viewModel, _) => const SizedBox(),
    );
  }
}
