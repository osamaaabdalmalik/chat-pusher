import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:pusher/features/auth/presentation/controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Chat',
      logo: const AssetImage('assets/image/chat.png'),
      onLogin: (loginData) {
        return;
      },
      onSignup: (signupData) {
        return;
      },
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => const DashboardScreen(),
        // ));
      },
      onRecoverPassword: (val) {
        return;
      },
    );
  }
}
