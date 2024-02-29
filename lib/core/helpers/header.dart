import 'package:get/get.dart';

setHeaders() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'lang': Get.locale!.languageCode.toString(),
    };

setHeadersWithToken({String? token}) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'lang': Get.locale!.languageCode.toString(),
    };
