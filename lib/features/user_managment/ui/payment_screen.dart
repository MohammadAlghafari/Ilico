import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/ui/widgets/Coustom_Button.dart';
import 'package:charja_charity/core/utils/Navigation/Navigation.dart';
import 'package:charja_charity/features/user_managment/bloc/payment_cubit.dart';
import 'package:charja_charity/features/user_managment/data/model/supscription_model.dart';
import 'package:charja_charity/features/user_managment/data/usecase/payment_usecase.dart';
import 'package:charja_charity/features/user_managment/ui/sp_Sing_up_Business_informations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/ui/dialogs/app_dialog.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/ui/widgets/loading.dart';
import '../../../core/utils/cashe_helper.dart';
import '../widgets/sign_header_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.supscription}) : super(key: key);
  final Supscription supscription;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  PaymentCubit cubit = PaymentCubit();
  String massege = "no error";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 232.h,
        automaticallyImplyLeading: false,
        // leading: Icon(Icons.arrow_back),
        centerTitle: true,
        //  title:
        flexibleSpace: SignHeader(
          // height: 283.h,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 34.w,
                    ),
                    InkWell(
                      onTap: () {
                        Navigation.pop();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    SizedBox(
                      width: 34.w,
                    ),
                    Text(
                      "Create your account",
                      style: AppTheme.headline2.copyWith(color: AppColors.kWhiteColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26.h,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(Icon_Steps),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(centerLine),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(iconFilled),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(endLine),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Subscriptions",
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Payment",
                          style: AppTheme.headline5.copyWith(color: AppColors.kWhiteColor, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 45.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          /* mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,*/
          children: [
            Text('Card Form', style: AppTheme.bodyText2.copyWith(fontSize: 14)),
            CardFormField(
              style: CardFormStyle(
                  backgroundColor: AppColors.kWhiteColor,
                  textColor: AppColors.kBlackColor,
                  placeholderColor: AppColors.kPDarkBlueColor,
                  borderColor: AppColors.kGrayBorder,
                  borderRadius: 15),
              controller: CardFormEditController(),
            ),
            SizedBox(
              height: 0.2.sh,
            ),
            BlocConsumer(
              bloc: cubit,
              builder: (BuildContext context, state) {
                if (state is PaymentLoading) {
                  return const Center(child: LoadingIndicator());
                }
                return Row(
                  children: [
                    Expanded(
                        child: CoustomButton(
                      function: () async {
                        cubit.startPay();
                        print("package Id :${widget.supscription.id.toString()}");
                        var result = await Stripe.instance.createPaymentMethod(
                            params: const PaymentMethodParams.card(
                                paymentMethodData: PaymentMethodData(billingDetails: BillingDetails())));
                        print("payment Method Id: ${result.id.toString()}");
                        if (result.id != null) {
                          cubit.addPayment(PaymentParams(
                              packageID: widget.supscription.id.toString(), paymentMethodID: result.id.toString()));
                        } else {
                          cubit.errorPay();
                        }
                        // print(result);
                      },
                      backgoundColor: AppColors.kWhiteColor,
                      borderSideColor: AppColors.kPDarkBlueColor,
                      borderRadius: 10.0.r,
                      buttonName: "Pay ${widget.supscription.price}€ and Continue",
                    ))
                  ],
                );
              },
              listener: (BuildContext context, Object? state) {
                if (state is PaymentLoaded) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AppDialog(
                          isHaveCancel: false,
                          Confirm: "OK",
                          btnWidth: 114.w,
                          buildContext: context,
                          body: WillPopScope(
                            onWillPop: () {
                              print("from will pop : true");
                              CashHelper.saveData(key: isPay, value: true);
                              Navigation.pushAndRemoveUntil(
                                  SPSingUpBusinessInformations(supscription: widget.supscription));
                              return Future.value();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(checkCircle),
                                Text(
                                  "Congratulations",
                                  style: AppTheme.headline3
                                      .copyWith(fontWeight: FontWeight.w500, color: AppColors.kPDarkBlueColor),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  "Your payment has been succeeded",
                                  style: AppTheme.subtitle1.copyWith(color: AppColors.kDimBlue, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          function: () {
                            CashHelper.saveData(key: isPay, value: true);
                            Navigation.pushAndRemoveUntil(
                                SPSingUpBusinessInformations(supscription: widget.supscription));
                          }).showDialog(context);
                    },
                  );
                } else if (state is PaymentError) {
                  Dialogs.showSnackBar(
                      message: (state.error?.message?.first.toString())!, typeSnackBar: AnimatedSnackBarType.error);
                }
              },
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
