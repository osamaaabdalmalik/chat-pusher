
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthController extends GetxController{

  @override
  void onInit() {
    Get.find<Logger>().i("Start onInit AuthController");
    super.onInit();
    Get.find<Logger>().f("End onInit AuthController");
  }

}