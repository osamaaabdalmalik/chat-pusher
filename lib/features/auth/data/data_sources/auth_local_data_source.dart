import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/features/auth/data/models/user_auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<Unit> setUser({required UserAuthModel userAuthModel});

  Future<UserAuthModel?> getUser();

  Future<Unit> clear();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences pref;

  AuthLocalDataSourceImpl({
    required this.pref,
  });

  @override
  Future<Unit> setUser({required UserAuthModel userAuthModel}) async {
    Get.find<Logger>().i("Start setUser in AuthLocalDataSourceImpl");
    final isStoreUser = await pref.setString(AppKeys.user, json.encode(userAuthModel.toJson()));
    Get.find<Logger>().f(
      "End setUser in AuthLocalDataSourceImpl isStoreUser: $isStoreUser",
    );
    return Future.value(unit);
  }

  @override
  Future<UserAuthModel?> getUser() {
    Get.find<Logger>().i("Start getUser in AuthLocalDataSourceImpl");
    final String? userString = pref.getString(AppKeys.user);
    if (userString != null) {
      Get.find<Logger>().f(
        "End getUser in AuthLocalDataSourceImpl user: $userString",
      );
      return Future.value(UserAuthModel.fromJson(json.decode(userString)));
    }
    Get.find<Logger>().f(
      "End getUser in AuthLocalDataSourceImpl user: null",
    );
    return Future.value(null);
  }

  @override
  Future<Unit> clear() async {
    Get.find<Logger>().i("Start clear in AuthLocalDataSourceImpl");
    final removeUser = await pref.remove(AppKeys.user);
    Get.find<Logger>().f(
      "End clear in AuthLocalDataSourceImpl \nremoveUser: $removeUser",
    );
    return Future.value(unit);
  }
}
