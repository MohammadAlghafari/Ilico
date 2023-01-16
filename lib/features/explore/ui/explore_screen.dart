import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // InkWell(
            //     onTap: () {
            //       // initPaymentSheet(context, email: 'Lekaa.alawad@gmail.com', amount: 100);
            //       //  Navigation.push(const PaymentScreen());
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(left: 50, top: 50),
            //       child: Text('Last articles', style: AppTheme.headline3.copyWith(fontSize: 16)),
            //     )),
            // InkWell(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         height: 15.h,
            //       ),
            //       SizedBox(
            //         width: double.infinity,
            //         height: 300.h,
            //         child: ListView.separated(
            //             separatorBuilder: (context, index) => SizedBox(width: 10.w),
            //             physics: const BouncingScrollPhysics(),
            //             scrollDirection: Axis.horizontal,
            //             itemCount: 8,
            //             shrinkWrap: true,
            //             itemBuilder: (context, index) {
            //               return ArticleExplorItem(
            //                 fromListArticle: false,
            //               );
            //             }),
            //       ),
            //       SizedBox(
            //         height: 35.h,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Padding(
            //               padding: EdgeInsets.symmetric(horizontal: 3.w),
            //               child: CoustomButton(
            //                   buttonName: "View all articles",
            //                   backgoundColor: AppColors.kWhiteColor,
            //                   borderSideColor: AppColors.kPDarkBlueColor,
            //                   borderRadius: 10.0.r,
            //                   function: () async {}),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     Navigation.push(const ArticlesScreen());
            //   },
            // )
          ],
        ),
      ),
    );
  }

  // Future<void> initPaymentSheet(context, {required String email, required int amount}) async {
  //   try {
  //     // 1. create payment intent on the server
  //     // final response = await http.post(
  //     //     Uri.parse(
  //     //         'https://us-central1-stripe-checkout-flutter.cloudfunctions.net/stripePaymentIntentRequest'),
  //     //     body: {
  //     //       'email': email,
  //     //       'amount': amount.toString(),
  //     //     });
  //     //
  //     // final jsonResponse = jsonDecode(response.body);
  //     //ver result = Stripe.instance.re
  //
  //     //2. initialize the payment sheet
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: '',
  //         merchantDisplayName: 'Flutter Stripe Store Demo',
  //         customerId: "150",
  //         customerEphemeralKeySecret: 'lkm',
  //         style: ThemeMode.light,
  //       ),
  //     );
  //
  //     await Stripe.instance.presentPaymentSheet();
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Payment completed!')),
  //     );
  //   } catch (e) {
  //     if (e is StripeException) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error from Stripe: ${e.error.localizedMessage}'),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Error: $e')),
  //       );
  //     }
  //   }
  // }
}
