import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/constants/end_point.dart';
import '../../../core/http/graphQl_provider.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/utils/cashe_helper.dart';
import '../../../core/utils/google_sign_in_package.dart';
import '../../search/data/repository/search_repository.dart';
import '../../search/data/usecase/store_location_usecase.dart';
import '../data/bloc/login_cubit.dart';
import '../ui/Sp_Sing_Up_Subscriptions.dart';
import '../ui/mobile_phone_screen.dart';

class SignInWidget extends StatefulWidget {
  final String? roleKey;
  final bool fromLogin;
  final bool? isCustomer;
  final ValueChanged<bool>? onSuccess;
  const SignInWidget({Key? key, required this.fromLogin, this.onSuccess, this.roleKey, this.isCustomer})
      : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 117.h,
      color: AppColors.kLightColor,
      child: Column(
        children: [
          SizedBox(
            height: 21.h,
          ),
          Text(
            "Or sign in with".tr(),
            style: AppTheme.subtitle2.copyWith(fontSize: 14),
          ),
          SizedBox(
            height: 11.h,
          ),
          SignInWithWidget(
            onSuccess: widget.onSuccess,
            isCustomer: widget.isCustomer,
            isFromLogin: widget.fromLogin,
            roleKey: widget.roleKey,
          )
        ],
      ),
    );
  }
}

class SignInWithWidget extends StatefulWidget {
  final bool isFromLogin;
  final String? roleKey;
  final bool? isCustomer;
  final ValueChanged<bool>? onSuccess;
  const SignInWithWidget({Key? key, this.onSuccess, required this.isFromLogin, this.isCustomer, this.roleKey})
      : super(key: key);

  @override
  State<SignInWithWidget> createState() => _SignInWithWidgetState();
}

class _SignInWithWidgetState extends State<SignInWithWidget> {
  LoginCubit loginCubit = LoginCubit();
  Map<String, dynamic>? _userData;
  bool checking = true;
  AccessToken? _accessToken;
  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    setState(() {
      checking = false;
    });
    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _loginFacebook();
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
  GoogleSignInAccount? _currentUser;

  _loginFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ["email", "public_profile"]);
    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
      print(userData["name"]);
      print(userData["email"]);
      print(userData["picture"]["data"]["url"]);
      print(userData["id"]);
      if (result != null && userData != null) {
        widget.isFromLogin
            ? loginCubit.getFacebookWithLogin(id: userData["id"], email: userData["email"])
            : Navigation.push(MobilePhoneScreen(
                isApple: false,
                isCustomer: widget.isCustomer,
                isGoogle: false,
                id: userData["id"],
                lastName: userData["name"],
                firstName: userData["name"],
                email: userData["email"],
                photoUrl: userData["picture"]["data"]["url"],
                rolKey: widget.roleKey,
              ));
      }
      // print(_accessToken!.token.toString());
    } else {
      // print(_accessToken!.token.toString());
    }
    setState(() {
      checking = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      _googleSignIn.signInSilently();
    });
    _googleSignIn.signInSilently();
    GoogleSignInAccount? user = _currentUser;
    print('tokenId ${user?.idToken}');
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      widget.isFromLogin
          ? BlocConsumer(
              bloc: loginCubit,
              listener: (context, state) {
                if (state is LoginSuccess) {
                  CashHelper.saveData(key: kACCESSTOKEN, value: state.loginModel.accessToken);
                  CashHelper.saveData(key: kREFRESHTOKEN, value: state.loginModel.refreshToken);
                  CashHelper.saveData(
                      key: kAccessTOKENEXPIRATIONDATE, value: state.loginModel.accessTokenExpirationDate);
                  CashHelper.saveData(
                      key: REFRESHTOKENEXPIRATIONDATE, value: state.loginModel.refreshTokenExpirationDate);
                  CashHelper.saveData(key: userType, value: state.loginModel.userType);

                  GraphQlProvider.setQlLink(auth: true);
                  if (state.loginModel.userStatus == "InActive" && state.loginModel.userType == "ServiceProvider") {
                    Navigation.push(const SpSingUpSubscriptions());
                  } else {
                    CashHelper.saveData(key: isPay, value: true);
                    widget.onSuccess?.call(true);
                    if (CashHelper.getData(key: LATITUDE) != null && CashHelper.getData(key: LONGITUDE) != null) {
                      StoreLocationUseCase(SearchRepository()).call(
                          params: StoreLocationParams(
                              latitude: CashHelper.getData(key: LATITUDE),
                              longitude: CashHelper.getData(key: LONGITUDE)));
                    }
                  }
                  //Navigation.push(RootScreen());
                } else if (state is LoginError) {
                  Dialogs.showSnackBar(
                      message: (state.error?.message?.first.toString())!, typeSnackBar: AnimatedSnackBarType.error);
                }
              },
              builder: (context, state) {
                return InkWell(
                  onTap: () async {
                    GoogleSignInAccount? user = _currentUser;
                    var result = await signInGoogle();
                    if (result?.id != null && result?.displayName != null && result?.email != null) {
                      loginCubit.getGoogleWithLogin(id: result?.id, email: result?.email);
                    }
                    print('tokenId ${user?.idToken}');
                  },
                  child: SignInItem(
                    imageAsset: "assets/icons/google_icon.png",
                    text: 'Google'.tr(),
                  ),
                );
              },
            )
          : InkWell(
              onTap: () async {
                GoogleSignInAccount? user = _currentUser;
                var result = await signInGoogle();
                print(result);
                print(result.email.toString());
                if (result?.id != null && result?.displayName != null && result?.email != null) {
                  Navigation.push(MobilePhoneScreen(
                    isApple: false,
                    isCustomer: widget.isCustomer,
                    isGoogle: true,
                    id: user?.id,
                    lastName: result?.displayName,
                    firstName: result?.displayName,
                    email: result?.email,
                    photoUrl: result?.photoUrl,
                    rolKey: widget.roleKey,
                  ));
                }

                print('tokenId ${user?.idToken.toString()}');
                print(user?.idToken.toString());
                print(user?.serverAuthCode);
              },
              child: SignInItem(
                imageAsset: "assets/icons/google_icon.png",
                text: 'Google'.tr(),
              ),
            ),
      InkWell(
        child: SignInItem(
          imageAsset: "assets/icons/facebook_icon.png",
          text: 'Facebook'.tr(),
        ),
        onTap: () {
          _loginFacebook();

          setState(() {});
        },
      ),
      InkWell(
        child: SignInItem(
          imageAsset: "assets/icons/linked_in_icon.png",
          text: 'LinkedIn'.tr(),
        ),
        onTap: () async {
          final credential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          if (widget.isFromLogin) {
            if (credential != null) {
              loginCubit.getAppleWithLogin(email: credential.email, appleProfileId: credential.userIdentifier);
            }
          } else {
            if (credential != null) {
              Navigation.push(MobilePhoneScreen(
                isApple: true,
                isCustomer: widget.isCustomer,
                isGoogle: false,
                id: credential.userIdentifier,
                lastName: credential.familyName,
                firstName: credential.givenName,
                email: credential.email,
                photoUrl: null,
                rolKey: widget.roleKey,
              ));
            }
          }

          print(credential);
        },
      ),
    ]);
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future signInGoogle() async {
    try {
      var result = await _googleSignIn.signIn();
      print('token google:${result?.idToken.toString()}');
      print(result!.email);
      print(result.id);
      print(result.displayName);
      print(result.photoUrl);
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('the error sign in $e');
      }
    }
  }

  // Future<void> signInApple() async {
  //   final result=await
  // }
}

class SignInItem extends StatelessWidget {
  SignInItem({super.key, required this.text, required this.imageAsset});
  String imageAsset;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.kGreyLight),
        color: AppColors.kWhiteColor,
      ),
      width: 104.62.w,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(imageAsset),
          Text(
            text,
            style: AppTheme.subtitle2.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}
