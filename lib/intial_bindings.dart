import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/helpers/network_info.dart';
import 'package:pusher/core/services/api_service.dart';
import 'package:pusher/core/services/easy_loader_service.dart';

class InitialBindings extends Bindings {
  @override
  dependencies() async {
    Get.put(Logger());
    Get.put(EasyLoaderService());
    Get.put(InternetConnectionChecker());
    Get.put<NetworkInfo>(NetworkInfoImpl(Get.find()));
    Get.put(ApiService(
      client: http.Client(),
      networkInfo: Get.find(),
    ));
  }
}
