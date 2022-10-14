import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/core/components/global_widgets/appBar/custom_app_bar.dart';
import 'package:money_app/views/top_up/top_up_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/components/global_widgets/buttons/button.dart';
import '../../core/components/global_widgets/buttons/numpad_button.dart';
import '../../core/components/global_widgets/customTextFormField/custom_text_form_field.dart';

class TopUpView extends StatelessWidget {
  const TopUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TopUpViewModel>(
      viewModel: Provider.of<TopUpViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      portraitOnPageBuilder: (context, viewModel, _) => Scaffold(
          appBar: const AppBarCustom(title: "MoneyApp",showBackButton: false,showCircularCloseButton: true,),
          body:  GestureDetector(
            onTap: () {
              viewModel.onTapSpace();
            },
            child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 76.h),
                    child: Center(
                        child: Text(
                          "howMuch".tr(),
                          style: Theme.of(context).textTheme.headline2,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 37.h),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "£",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          buildTextFormField(
                              viewModel,
                              context,
                              5,
                              EdgeInsets.only(bottom: -10.h),
                              viewModel.intEditingController,
                              Theme.of(context).textTheme.headline6!,
                              viewModel.intFocusNode, () {
                            viewModel.intEditingController.selection =
                                TextSelection.collapsed(
                                    offset: viewModel
                                        .intEditingController.text.length);
                          }),
                          Text(".",
                              style: (Theme.of(context).textTheme.headline2)),
                          buildTextFormField(
                              viewModel,
                              context,
                              5,
                              EdgeInsets.zero,
                              viewModel.decimalEditingController,
                              Theme.of(context).textTheme.headline2!,
                              viewModel.decimalFocusNode, () {
                            viewModel.decimalEditingController.selection =
                                TextSelection.collapsed(
                                    offset: viewModel
                                        .decimalEditingController.text.length);
                          }),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 90.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            numOfNumPad(context, viewModel, "1"),
                            numOfNumPad(context, viewModel, "2"),
                            numOfNumPad(context, viewModel, "3"),
                          ],
                        ),
                        //SizedBox(height: 20.sp,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            numOfNumPad(context, viewModel, "4"),
                            numOfNumPad(context, viewModel, "5"),
                            numOfNumPad(context, viewModel, "6"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            numOfNumPad(context, viewModel, "7"),
                            numOfNumPad(context, viewModel, "8"),
                            numOfNumPad(context, viewModel, "9"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            doubtButtonOfNumpad(context, viewModel),
                            numOfNumPad(context, viewModel, "0"),
                            removeButtonOfNumPad(context, viewModel),
                          ],
                        ),

                        Padding(
                          padding: EdgeInsets.only(bottom: 27.h, top: 80.h),
                          child: CustomButton(
                            text: "topUp".tr(),
                            onPressed: (){
                              viewModel.onTopUpButtonPress();
                            },
                              butonColor: Theme.of(
                            context)
                                .secondaryHeaderColor
                                .withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
      landscapeOnPageBuilder: (context, viewModel, _) => const SizedBox(),
    );
  }

  IntrinsicWidth buildTextFormField(
      TopUpViewModel viewModel,
      BuildContext context,
      int lengthLimit,
      EdgeInsetsGeometry contentPadding,
      TextEditingController controller,
      TextStyle textStyle,
      FocusNode focusNode,
      Function() onTap) {
    return IntrinsicWidth(
      child: CustomTextFormField(
        textInputType: TextInputType.none,
        inputFormatter: [
          LengthLimitingTextInputFormatter(lengthLimit),
        ],
        contentPadding: contentPadding,
        controller: controller,
        textStyle: textStyle,
        lineColor: Theme.of(context).backgroundColor,
        focusNode: focusNode,
        onTap: onTap,
      ),
    );
  }

  Expanded numOfNumPad(
      BuildContext context, TopUpViewModel viewModel, String number) {
    return Expanded(
      child: NumPadButton(
        child: Text(
          number,
          style: Theme.of(context).textTheme.headline2,
        ),
        onPressed: () {
          if (FocusScope.of(context).focusedChild == viewModel.intFocusNode) {
            if (viewModel.intEditingController.text == "0") {
              viewModel.intEditingController.text = number;
              viewModel.intEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.intEditingController.text.length);
            } else if (viewModel.intEditingController.text.length < 5) {
              viewModel.intEditingController.text =
              "${viewModel.intEditingController.text}$number";
              viewModel.intEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.intEditingController.text.length);
            }
          }
          if (FocusScope.of(context).focusedChild ==
              viewModel.decimalFocusNode) {
            if (viewModel.decimalEditingController.text == "00") {
              viewModel.decimalEditingController.text = number;
              viewModel.decimalEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.decimalEditingController.text.length);
            } else if (viewModel.decimalEditingController.text.length < 2) {
              viewModel.decimalEditingController.text =
              "${viewModel.decimalEditingController.text}$number";
              viewModel.decimalEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.decimalEditingController.text.length);
            }
          }
        },
      ),
    );
  }

  Expanded doubtButtonOfNumpad(BuildContext context, TopUpViewModel viewModel) {
    return Expanded(
      child: NumPadButton(
        child: Text(
          ".",
          style: Theme.of(context).textTheme.headline2,
        ),
        onPressed: () {
          FocusScope.of(context).requestFocus(viewModel.decimalFocusNode);
          viewModel.decimalEditingController.selection =
              TextSelection.collapsed(
                  offset: viewModel.decimalEditingController.text.length);
        },
      ),
    );
  }

  Expanded removeButtonOfNumPad(BuildContext context, TopUpViewModel viewModel) {
    return Expanded(
      child: NumPadButton(
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).backgroundColor,
        ),
        onPressed: () {
          if (FocusScope.of(context).focusedChild == viewModel.intFocusNode) {
            if (viewModel.intEditingController.text.isNotEmpty) {
              viewModel.intEditingController.text = viewModel
                  .intEditingController.text
                  .substring(0, viewModel.intEditingController.text.length - 1);
              viewModel.intEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.intEditingController.text.length);
            }
          }
          if (FocusScope.of(context).focusedChild ==
              viewModel.decimalFocusNode) {
            if (viewModel.decimalEditingController.text.isNotEmpty) {
              viewModel.decimalEditingController.text =
                  viewModel.decimalEditingController.text.substring(
                      0, viewModel.decimalEditingController.text.length - 1);
              viewModel.decimalEditingController.selection =
                  TextSelection.collapsed(
                      offset: viewModel.decimalEditingController.text.length);
            }
          }
        },
      ),
    );
  }
}
