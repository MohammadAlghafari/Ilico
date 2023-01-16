import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:charja_charity/features/user_managment/bloc/login_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linkedin_login/linkedin_login.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/ui/dialogs/dialogs.dart';
import '../../../core/utils/google_sign_in_package.dart';

class SignInWidget extends StatefulWidget {
  final bool fromLogin;
  const SignInWidget({Key? key, required this.fromLogin}) : super(key: key);

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
            "Or sign in with ",
            style: AppTheme.subtitle2.copyWith(fontSize: 14),
          ),
          SizedBox(
            height: 11.h,
          ),
          SignInWithWidget(
            isFromLogin: widget.fromLogin,
          )
        ],
      ),
    );
  }
}

class SignInWithWidget extends StatefulWidget {
  final bool isFromLogin;
  const SignInWithWidget({Key? key, required this.isFromLogin}) : super(key: key);

  @override
  State<SignInWithWidget> createState() => _SignInWithWidgetState();
}

class _SignInWithWidgetState extends State<SignInWithWidget> {
  LoginCubit cubit = LoginCubit();
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
      BlocConsumer(
        bloc: cubit,
        listener: (context, state) {
          if (widget.isFromLogin) {
            if (state is LoginWithGoogleSuccess) {
              print('success');
            } else if (state is LoginWithGoogleError) {
              Dialogs.showSnackBar(
                  message: (state.error?.message?.first.toString())!, typeSnackBar: AnimatedSnackBarType.error);
            }
          }
        },
        builder: (context, state) {
          if (state is LoginWithGoogleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return InkWell(
              onTap: () async {
                GoogleSignInAccount? user = _currentUser;
                String? result = await signInGoogle();
                if (result != null) {
                  widget.isFromLogin ? cubit.getGoogleWithLogin() : '';
                }
                print('tokenId ${user?.idToken}');
              },
              child: SignInItem(
                imageAsset: "assets/icons/google_icon.png",
                text: 'Google',
              ),
            );
          }
        },
      ),
      InkWell(
        child: SignInItem(
          imageAsset: "assets/icons/facebook_icon.png",
          text: 'Facebook',
        ),
        onTap: () {
          _loginFacebook();

          setState(() {});
        },
      ),
      InkWell(
        child: SignInItem(
          imageAsset: "assets/icons/linked_in_icon.png",
          text: 'LinkedIn',
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LinkedInUserWidget(
                        redirectUrl: 'https://www.linkedin.com/developers/tools/oauth/redirect',
                        clientId: '7869bet6ub3ha0',
                        clientSecret: 'dsp9L4h7Rxbc9Mce',
                        onGetUserProfile: (UserSucceededAction linkedInUser) {
                          print('Access token ${linkedInUser.user.token.accessToken}');
                          print('First name: ${linkedInUser.user.firstName}');
                          print('Last name: ${linkedInUser.user.lastName}');
                        },
                        onError: (UserFailedAction e) {
                          print('Error: ${e.toString()}');
                        },
                      )));
        },
      ),
    ]);
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future<String?> signInGoogle() async {
    try {
      var result = await _googleSignIn.signIn();
      print('token google:${result?.idToken.toString()}');
      return result?.idToken.toString();
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
