import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/services/shared_preferences_service.dart';
import 'package:pusher/features/auth/data/models/user_auth_model.dart';

abstract class AuthLocalDataSource {
  Future<Unit> setUser({required UserAuthModel userAuthModel});

  Future<UserAuthModel?> getUser();

  Future<Unit> clear();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferencesService sharedPreferencesService;

  AuthLocalDataSourceImpl({
    required this.sharedPreferencesService,
  });

  @override
  Future<Unit> setUser({required UserAuthModel userAuthModel}) async {
    Get.find<Logger>().i("Start setUser in AuthLocalDataSourceImpl");
    await sharedPreferencesService.setData(
      key: AppKeys.user,
      value: json.encode(userAuthModel.toJson()),
    );
    Get.find<Logger>().w("End setUser in AuthLocalDataSourceImpl");
    return Future.value(unit);
  }

  @override
  Future<UserAuthModel?> getUser() {
    Get.find<Logger>().i("Start getUser in AuthLocalDataSourceImpl");
    final String? userString = sharedPreferencesService.getData<String>(key: AppKeys.user);
    if (userString != null) {
      Get.find<Logger>().w(
        "End getUser in AuthLocalDataSourceImpl user: $userString",
      );
      return Future.value(UserAuthModel.fromJson(json.decode(userString)));
    }
    Get.find<Logger>().w(
      "End getUser in AuthLocalDataSourceImpl user: null",
    );
    return Future.value(null);
  }

  @override
  Future<Unit> clear() async {
    Get.find<Logger>().i("Start clear in AuthLocalDataSourceImpl");
    final removeUser = await sharedPreferencesService.clear();
    Get.find<Logger>().w(
      "End clear in AuthLocalDataSourceImpl \nremoveUser: $removeUser",
    );
    return Future.value(unit);
  }
}
