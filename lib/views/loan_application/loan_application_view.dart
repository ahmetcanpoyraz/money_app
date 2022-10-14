import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_app/core/components/global_widgets/appBar/custom_app_bar.dart';
import 'package:money_app/core/components/global_widgets/buttons/button.dart';
import 'package:money_app/core/components/global_widgets/customTextFormField/custom_text_form_field.dart';
import 'package:provider/provider.dart';
import '../../../core/base/base_view/base_view.dart';
import '../../core/components/global_widgets/switch_adaptive/text_with_switch_adaptive.dart';
import 'loan_application_viewmodel.dart';

class LoanApplicationView extends StatelessWidget {
  const LoanApplicationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoanApplicationViewModel>(
      viewModel: Provider.of<LoanApplicationViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      portraitOnPageBuilder: (context, viewModel, _) => Scaffold(
        resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: false,
          appBar:  AppBarCustom(title: "loanApplication".tr(),showBackButton: true),
          body:  GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              reverse: true,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: 7.h,left: 17.w,bottom: 7.h),
                    child: Text("termsandConditions".tr(),style: Theme.of(context).textTheme.headlineLarge,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Text("loremIpsum".tr(),style: Theme.of(context).textTheme.subtitle2,textAlign: TextAlign.justify,),
                  ),
                  SizedBox(height: 11.h,),
                  TextWithSwitchAdaptive(
                    edgeInsetsGeometry: EdgeInsets.symmetric(vertical: 17.h,horizontal: 16.w),
                    textWidget: Text("acceptTerms".tr(),style: Theme.of(context).textTheme.bodyText2,),
                    backgroundColor: Theme.of(context).backgroundColor,
                    onChange: (value){
                              viewModel.changeSwitchAdaptiveValue(value);
                            },
                    value: viewModel.switchAdaptiveValue,
                  ),
                  SizedBox(height: 11.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Text("aboutYou".tr(),style: Theme.of(context).textTheme.bodyText2,),
                  ),
                  SizedBox(height: 4.h,),
                   buildContainerForInputForAboveText(context, viewModel,"monthlySalary".tr(),viewModel.monthlySalaryController,6,true),
                   buildContainerForInputForAboveText(context, viewModel,"monthlyExpense".tr(),viewModel.monthlyExpensesController,6,true),
                  SizedBox(height: 15.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    child: Text("loan".tr().toUpperCase(),style: Theme.of(context).textTheme.bodyText2,),
                  ),
                  SizedBox(height: 4.h,),
                  buildContainerForInputForAboveText(context, viewModel,"amount".tr(),viewModel.loanAmountController,7,true),
                  buildContainerForInputForAboveText(context, viewModel,"term".tr(),viewModel.loanTermController,3,false),
                  SizedBox(height: 62.h,),
                  Center(child: CustomButton(
                    butonColor: Theme.of(context).primaryColor,
                    onPressed: (){
                      if(!viewModel.switchAdaptiveValue){
                        viewModel.showAlertForAcceptTermAndConditions();
                      }else{
                        if(viewModel.loanTermController.text == "" || viewModel.loanAmountController.text == ""
                            || viewModel.monthlyExpensesController.text == "" || viewModel.monthlySalaryController.text == ""){
                          viewModel.showAlertForEmptyData();
                        }else{
                          viewModel.runLoanDecisionService();
                        }
                      }
                    },
                    text: "applyforLoan".tr(),
                  ),),
                SizedBox(height: 10.h,),
                Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom))
              ],),
            ),
          )
      ),
      landscapeOnPageBuilder: (context, viewModel, _) => const SizedBox(),
    );
  }

  Container buildContainerForInputForAboveText(BuildContext context, LoanApplicationViewModel viewModel,String text,TextEditingController controller,int lentghLimit,bool showCurrency) {
    return Container(
                  color: Theme.of(context).backgroundColor,
                  width: double.infinity,
                  child: Padding(
                    padding:  EdgeInsets.only(left: 16.w,right: 16.w,bottom: 14.h,top: 2.h  ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400,color: Theme.of(context).shadowColor),),
                        Row(children: [
                          Visibility(
                              visible: showCurrency,
                              child: Text("£",style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),)),
                          SizedBox(
                            width: 320.w,
                            child: CustomTextFormField(
                              contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                              lineColor: Theme.of(context).hoverColor,
                              textStyle: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
                              controller: controller,
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(lentghLimit),
                                FilteringTextInputFormatter.digitsOnly],
                              textInputType: TextInputType.number,
                              validator: (text){
                                return "";
                              },
                            ),
                          ),
                        ],)
                      ],
                    ),
                  ),
                );
  }
}
