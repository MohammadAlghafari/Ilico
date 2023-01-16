import 'package:flutter/material.dart';

import '../../../features/user_managment/ui/login_screen.dart';
import '../../utils/cashe_helper.dart';

class CheckAuthPage extends StatefulWidget {
  const CheckAuthPage({required this.loggedInWidget, Key? key}) : super(key: key);

  final Widget loggedInWidget;

  @override
  State<CheckAuthPage> createState() => _CheckAuthPageState();
}

class _CheckAuthPageState extends State<CheckAuthPage> {
  @override
  Widget build(BuildContext context) {
    return CashHelper.authorized
        ? widget.loggedInWidget
        : LoginScreen(
            onSuccess: (value) {
              if (value) {
                setState(() {});
                print('value $value');
                print('authorized ${CashHelper.authorized}');
              }
            },
          );
  }
}
