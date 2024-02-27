import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService extends GetxService {
  final String token;

  final String _appId = "";

  OneSignalService({required this.token});

  @override
  void onInit() {
    Get.find<Logger>().i('Start onInit in OneSignalService');
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Notifications.requestPermission(true);
    OneSignal.consentRequired(true);
    OneSignal.consentGiven(true);
    OneSignal.initialize(_appId);

    Get.find<Logger>().f('End onInit in OneSignalService');
    super.onInit();
  }

  void addClickListenerToNotification({
    required Function(OSNotificationClickEvent) event,
  }) {
    OneSignal.Notifications.addClickListener(event);
  }

  void addClickListenerToForegroundNotification({
    required Function(OSNotificationWillDisplayEvent) event,
  }) {
    OneSignal.Notifications.addForegroundWillDisplayListener(event);
  }

  void sendUserTag(String tagName, int userId) {
    // TODO I think that it is not correct
    OneSignal.User.addTags({tagName: userId.toString()}).then((response) {
      Get.find<Logger>().i("Successfully sent tags with response");
    }).catchError((error) {
      Get.find<Logger>().f("Encountered an error sending tags: $error");
    });
  }

  void deleteUserTag(String tagName) {
    OneSignal.User.removeTag(tagName).then((response) {
      Get.find<Logger>().i("Successfully deleted tags with response");
    }).catchError((error) {
      Get.find<Logger>().f("Encountered error deleting tag: $error");
    });
  }
}
