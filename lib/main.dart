import 'dart:io';

import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/utils/Keys.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '.env';
import 'core/constants/app_styles.dart';
import 'core/ui/onbording/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await CashHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  await initHiveForFlutter();

  // CashHelper.sharedPreferences.clear();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: Keys.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Illico 1',
          theme: ThemeData(
              textTheme: AppTheme.textTheme,
              primarySwatch: Colors.blue,
              iconTheme: const IconThemeData(color: AppColors.kPDarkBlueColor)),
          home: const SplashScreen(),
        );
      },
    );
  }
}
