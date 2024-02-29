import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_api_routes.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/helpers/get_exception_from_status_code.dart';
import 'package:pusher/core/helpers/header.dart';
import 'package:pusher/core/helpers/network_info.dart';
import 'package:pusher/core/services/shared_preferences_service.dart';
import 'package:pusher/features/auth/data/models/user_auth_model.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';

class ApiService extends GetxService {
  final http.Client client;
  final NetworkInfo networkInfo;
  UserAuth? userAuth;

  ApiService({
    required this.client,
    required this.networkInfo,
  });

  @override
  void onInit() {
    Get.find<Logger>().i('Start `onInit` in ApiServiceImpl');
    getUserAuth();
    Get.find<Logger>().w('End `onInit` in ApiServiceImpl');
    super.onInit();
  }

  void getUserAuth() {
    Get.find<Logger>().i('Start `getUserAuth` in ApiServiceImpl');
    String? user = Get.find<SharedPreferencesService>().getData<String>(
      key: AppKeys.user,
    );
    if (user != null) {
      userAuth = UserAuthModel.fromJson(json.decode(user));
    }
    Get.find<Logger>().w('End `getUserAuth` in ApiServiceImpl');
  }

  Future<Map<String, dynamic>> post({
    required String subUrl,
    required Map<String, dynamic> data,
    bool needToken = false,
  }) async {
    try {
      Get.find<Logger>().i('Start post `$subUrl` |ApiServiceImpl|  data: $data');
      // if (!(await networkInfo.isConnected)) {
      //   throw OfflineException();
      // }
      final response = await client.post(
        Uri.http(
          AppApiRoutes.baseUrl,
          subUrl,
        ),
        body: json.encode(data),
        headers: needToken ? setHeadersWithToken(token: userAuth!.token) : setHeaders(),
      );
      getExceptionStatusCode(response);
      Get.find<Logger>().w('End post `$subUrl` |ApiServiceImpl| response: ${json.decode(response.body)}');
      return Future.value(json.decode(response.body));
    } catch (e, s) {
      Get.find<Logger>().e('End post `$subUrl` |ApiServiceImpl| Exception: ${e.runtimeType}, $s');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get({
    required String subUrl,
    Map<String, String>? parameters,
    bool needToken = false,
    String? key,
  }) async {
    try {
      Get.find<Logger>().i('Start get `$subUrl` |ApiServiceImpl| parameters: $parameters');
      // if (!(await networkInfo.isConnected)) {
      //   throw OfflineException();
      // }
      parameters?.removeWhere((key, value) => value == 'null');
      final response = await client.get(
        Uri.http(
          AppApiRoutes.baseUrl,
          subUrl,
          parameters,
        ),
        headers: needToken ? setHeadersWithToken(token: userAuth!.token) : setHeaders(),
      );
      getExceptionStatusCode(response);
      Get.find<Logger>().w('End get `$subUrl` |ApiServiceImpl| response: ${response.body}');
      return Future.value((json.decode(response.body)));
    } catch (e, s) {
      Get.find<Logger>().e('End get `$subUrl` |ApiServiceImpl| Exception: ${e.runtimeType} $s');
      rethrow;
    }
  }
}
