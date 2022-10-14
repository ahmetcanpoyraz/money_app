import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_app/core/components/global_widgets/appBar/custom_app_bar.dart';
import 'package:money_app/core/components/global_widgets/switch_adaptive/text_with_switch_adaptive.dart';
import 'package:money_app/core/constants/assets_constants.dart';
import 'package:money_app/core/constants/color_constants.dart';
import 'package:money_app/views/transaction_detail/transaction_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';

class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionDetailViewModel>(
      viewModel:
          Provider.of<TransactionDetailViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      portraitOnPageBuilder: (context, viewModel, _) => Scaffold(
          appBar: const AppBarCustom(title: "MoneyApp", showBackButton: true),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 17.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Theme.of(context).primaryColor,
                          height: 64.h,
                          width: 64.h,
                          child: SvgPicture.asset(
                            viewModel.transactionModel.isPayment
                                ? AssetPath.payment_icon
                                : AssetPath.topup_icon,
                          ),
                        ),
                        Text(
                          viewModel.transactionModel.name,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          viewModel.convertDateFormat(
                              viewModel.transactionModel.createdAt),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0.w, top: 11.h),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            viewModel.transactionModel.money.toInt().toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  ".${viewModel.transactionModel.money.toString().split('.')[1]}",
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 47.sp,
              ),
              Container(
                color: Theme.of(context).backgroundColor,
                width: double.infinity,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 17.h, horizontal: 29.w),
                  child: Row(
                    children: [
                      SvgPicture.asset(AssetPath.recipt_icon),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        "addRecipt".tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: viewModel.transactionModel.isPayment,
                child: Column(
                  children: [
                    SizedBox(height: 57.h),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("sharetheCost".tr(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2)),
                    ),
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: () {
                        viewModel.splitThisBill();
                      },
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 17.h, horizontal: 29.w),
                          child: Row(
                            children: [
                              Container(
                                  color: ColorConstants.instance.kBoldPink,
                                  child: Padding(
                                    padding: EdgeInsets.all(2.0.w),
                                    child: SvgPicture.asset(
                                        AssetPath.split_bill_icon),
                                  )),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                "splitBill".tr(),
                                style: Theme.of(context).textTheme.bodyText2,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: viewModel.transactionModel.isPayment,
                child: Column(
                  children: [
                    SizedBox(height: 31.h),
                    Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("subscription".tr(),
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyText2)),
                    ),
                    SizedBox(height: 4.h),
                    TextWithSwitchAdaptive(
                      textWidget: Text(
                        "repeatingPayment".tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      edgeInsetsGeometry: EdgeInsets.symmetric(
                          vertical: 17.h, horizontal: 29.w),
                      value: viewModel.switchValue,
                      backgroundColor: Theme.of(context).backgroundColor,
                      onChange: (value) {
                        viewModel.repeatingPayment(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 57.h),
              GestureDetector(
                onTap: () {
                  viewModel.showAlertDialogForHelp();
                },
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 17.h, horizontal: 29.w),
                      child: Text(
                        "somethingWrong".tr(),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.red, fontWeight: FontWeight.w400),
                      )),
                ),
              ),
              SizedBox(height: 48.h),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Transaction ID #1223SD23RWDF2DFAS \ ${viewModel.transactionModel.name} - Merchant ID #1245",
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          )),
      landscapeOnPageBuilder: (context, viewModel, _) => const SizedBox(),
    );
  }
}
