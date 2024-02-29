import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/constants/app_pages_routes.dart';
import 'package:pusher/core/services/shared_preferences_service.dart';
import 'package:pusher/features/auth/data/models/user_auth_model.dart';

class MainMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String? user = Get.find<SharedPreferencesService>().getData<String>(
      key: AppKeys.user,
    );
    if (user != null) {
      return RouteSettings(name: AppPagesRoutes.chatsScreen, arguments: {
        AppKeys.user: UserAuthModel.fromJson(json.decode(user)),
      });
    }
    return null;
  }
}
