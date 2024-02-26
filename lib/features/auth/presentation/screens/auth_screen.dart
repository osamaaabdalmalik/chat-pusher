import 'package:pusher/core/constants/app_colors.dart';
import 'package:pusher/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Auth Screen",
        style: TextStyle(
          fontSize: 40,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
