// ignore_for_file: unnecessary_null_comparison
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:money_app/core/constants/assets_constants.dart';
import 'package:money_app/core/constants/navigation_constant.dart';
import 'package:money_app/core/init/navigation/navigation_service.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/components/global_widgets/appBar/custom_app_bar.dart';
import '../transaction_detail/transaction_detail_viewmodel.dart';
import 'transactions_viewmodel.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<TransactionsViewModel>(
      viewModel: Provider.of<TransactionsViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      portraitOnPageBuilder: (context, viewModel, _) => Scaffold(
          resizeToAvoidBottomInset: false,
        appBar:  AppBarCustom(title: "appName".tr(),showChangeLang: true,showChangeThemeButton: true,),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 200.h,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                          child: Text("recentActivity".tr(),style: Theme.of(context).textTheme.bodyText2,),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                          child: SizedBox(
                              height: 22.h,
                              child: Text("today".tr(),style: Theme.of(context).textTheme.subtitle2,)),
                        ),
                        buildTodayListViewBuilder(context, viewModel),
                        Padding(
                          padding:  EdgeInsets.only(left: 20.w,top: 6.h,bottom: 6.h),
                          child: Text("yesterday".tr(),style: Theme.of(context).textTheme.subtitle2,),
                        ),
                        buildYesterdayListViewBuilder(context, viewModel),
                      ],
                    ),
                  ),
                ),
            ],),
            Padding(
              padding:  EdgeInsets.fromLTRB(20.w,150.h,20.w,0),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 100.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.sp)),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(top: 12.h,bottom: 15.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildInkWell(
                            context,
                                (){
                          NavigationService.instance.navigateToPage(path: NavigationConstants.payPage);
                        },
                            AssetPath.phone_icon,
                            "pay".tr()
                        ),
                        buildInkWell(
                            context,
                                (){
                                  NavigationService.instance.navigateToPage(path: NavigationConstants.topUpPage);
                            },
                            AssetPath.wallet_icon,
                            "topUp".tr()
                        ),
                        buildInkWell(
                            context,
                                (){
                              NavigationService.instance.navigateToPage(path: NavigationConstants.loanApplicationPage);
                            },
                            AssetPath.loan_icon,
                            "loan".tr()
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 75.h,top:37.5.h),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "£",
                    style: Theme.of(context).textTheme.headline2,
                    children:  <TextSpan>[
                      TextSpan(text: viewModel.money.toInt().toString(), style: Theme.of(context).textTheme.headline1),
                      TextSpan(text: '.', style: Theme.of(context).textTheme.headline2),
                      TextSpan(text: viewModel.money.toString().split('.').length > 1
                          ? viewModel.money.toString().split('.')[1].toString().substring(0,2)
                          : viewModel.money.toString().split('.')[1].toString().substring(0,1)
                          , style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
      landscapeOnPageBuilder: (context, viewModel, _) => const SizedBox(),
    );
  }

  InkWell buildInkWell(BuildContext context,Function() onTap,String assetPath,String text) {
    return InkWell(
                        onTap: onTap,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          SvgPicture.asset(
                            assetPath,
                            height: 50.h,
                            width: 52.34.w,
                          ),
                          Text(text,style: Theme.of(context).textTheme.bodyText1,)

                        ],),
                      );
  }

  Container buildYesterdayListViewBuilder(BuildContext context, TransactionsViewModel viewModel) {
    return Container(
                          height: 150.h,
                          color: Theme.of(context).backgroundColor,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: context.watch<TransactionsViewModel>().yesterdayTransactionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  Provider.of<TransactionDetailViewModel>(context,listen:false).transactionModel = viewModel.yesterdayTransactionList[index];
                                  NavigationService.instance.navigateToPage(path: NavigationConstants.transactionDetailPage);
                                },
                                child: SizedBox(
                                  height: 50.h,
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(25.w,15.h,25.w,15.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              viewModel.yesterdayTransactionList[index].isPayment
                                                  ? AssetPath.payment_icon
                                                  : AssetPath.topup_icon,
                                              height: 20.h,
                                              width: 20.w,
                                            ),
                                            SizedBox(width: 8.sp,),
                                            Text(viewModel.yesterdayTransactionList[index].name,style: Theme.of(context).textTheme.bodyText2,)
                                          ],),
                                        viewModel.yesterdayTransactionList[index].isPayment
                                            ? Text(viewModel.yesterdayTransactionList[index].money.toStringAsFixed(2),style: Theme.of(context).textTheme.headline4,)
                                            : Text("+${viewModel.yesterdayTransactionList[index].money}",style: Theme.of(context).textTheme.headline5,)
                                      ],),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
  }

  Container buildTodayListViewBuilder(BuildContext context, TransactionsViewModel viewModel) {
    return Container(
                          color: Theme.of(context).backgroundColor,
                          height: 150.h,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: context.watch<TransactionsViewModel>().todayTransactionList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: (){
                                  Provider.of<TransactionDetailViewModel>(context,listen:false).transactionModel = viewModel.todayTransactionList[index];
                                  NavigationService.instance.navigateToPage(path: NavigationConstants.transactionDetailPage);
                                },
                                child: SizedBox(
                                  height: 50.h,
                                  child: Padding(
                                    padding:  EdgeInsets.fromLTRB(25.w,15.h,25.w,15.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      Row(
                                        children: [
                                         SvgPicture.asset(
                                           viewModel.todayTransactionList[index].isPayment
                                               ? AssetPath.payment_icon
                                           : AssetPath.topup_icon,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                        SizedBox(width: 8.sp,),
                                        Text(viewModel.todayTransactionList[index].name,style: Theme.of(context).textTheme.bodyText2,)
                                      ],),
                                        viewModel.todayTransactionList[index].isPayment
                                            ? Text(viewModel.todayTransactionList[index].money.toStringAsFixed(2),style: Theme.of(context).textTheme.headline4,)
                                            : Text("+${viewModel.todayTransactionList[index].money}",style: Theme.of(context).textTheme.headline5,)
                                    ],),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
  }
}
