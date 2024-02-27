import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pusher/features/auth/presentation/controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Chat Pusher',
      logo: const AssetImage('assets/image/chat.png'),
      onLogin: (loginData) async {
        await controller.login(loginData: loginData);
        return controller.validationMessage;
      },
      onSignup: (signupData) async {
        await controller.register(signupData: signupData);
        return controller.validationMessage;
      },
      savedEmail: "osama@gmail.com",
      savedPassword: '123456789',
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(loginTime);
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.linkedinIn,
          label: 'Linked',
          callback: () async {
            debugPrint('start linkdin sign in');
            await Future.delayed(loginTime);
            debugPrint('stop linkdin sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.githubAlt,
          label: 'Github',
          callback: () async {
            debugPrint('start github sign in');
            await Future.delayed(loginTime);
            debugPrint('stop github sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        // Get.find<Logger>().f("End");
      },
      onRecoverPassword: (p0) {
        return;
      },
    );
  }
}
