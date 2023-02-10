import 'dart:io';

import 'package:charja_charity/core/constants/app_colors.dart';
import 'package:charja_charity/core/utils/Keys.dart';
import 'package:charja_charity/core/utils/cashe_helper.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import 'package:connectycube_sdk/connectycube_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '.env';
import 'core/constants/app_styles.dart';
import 'core/constants/end_point.dart';
import 'core/http/graphQl_provider.dart';
import 'core/ui/onbording/splash_screen.dart';
import 'core/utils/language_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await CashHelper.init();
  HttpOverrides.global = MyHttpOverrides();
  await initHiveForFlutter();
  String? token = CashHelper.getData(key: kACCESSTOKEN);
  if (token != null) {
    GraphQlProvider.setQlLink(auth: true);
  }

  // CashHelper.sharedPreferences.clear();
  runApp(
    EasyLocalization(
        supportedLocales: const [LanguageHelper.kEnglishLocale, LanguageHelper.kFranceLocale],
        // supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CubeSession? cubesession;

  @override
  void initState() {
    super.initState();

    init(
      '6920',
      '2bQYsYHKPCfgFZn',
      'HVBBgBU7YePArVk',
    );
    CubeSettings.instance.isDebugEnabled = true;
    //CubeSettings.instance.setEndpoints(customApiEndpoint, customChatEndpoint);

    // CubeUser user = CubeUser(id: 7203376, password: "illico1@123QWE", login: "RahafBadria");
    CubeUser user = CashHelper.getChatUser();
    if (user.id != null) {
      createSession(user).then((cubeSession) async {
        print("createSession cubeSession: $cubeSession");

        CubeChatConnection.instance.login(user).then((loggedUser) {
          print("User logged in $loggedUser");
        }).catchError((error) {
          print("log in error $error");
        });
      }).catchError((error) {
        print("create session error $error");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: Keys.navigatorKey,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
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

//   initChat() async {
//     await init(
//       chat_config.APP_ID,
//       chat_config.AUTH_KEY,
//       chat_config.AUTH_SECRET,
//     );
//     CubeSettings.instance.isDebugEnabled = true;
//     CubeSettings.instance.setEndpoints(customApiEndpoint, customChatEndpoint);
//     CubeChatConnection.instance.logout();
//     CubeUser user = CubeUser(id: 7203376, password: "illico1@123QWE", login: "AnghamAboHadier");
//     print("before  create session");
//     cubesession = await createSession(user);
//     print("after  create session"); //create app session
// //registeredUser = await  signUp(user); //if necessary
//     var myuser = await signInByLogin(user.id!.toString(), user.password!);
//     print("after  create session");
//     var cubeSession = await createSession(myuser); //upgrade to user session
//     //var createdDialog = await  createDialog(newDialog); //is this for one time only? I can set the dialogId in the newDialog object but it is overwritten by a random uuid in the console. We should know what we can set and not clearly.
//     await CubeChatConnection.instance
//         .login(myuser); //login?? bad choice of a method mate. This starts the xmpp 2 way connection I guess.
//     CubeChatConnection.instance.chatMessagesManager?.chatMessagesStream;
//   }
}
