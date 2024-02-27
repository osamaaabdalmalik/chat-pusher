import 'package:get/get.dart';
import 'package:laravel_echo_null/laravel_echo_null.dart';
import 'package:logger/logger.dart';

class LaravelEchoService extends GetxService {
  static late Echo _echo;
  final String token;

  // final String _appId = "";
  final String _pusherAppKey = "";

  // final String _secret = "";
  final String _pusherCluster = "";
  final String _hostEndPoint = "";
  final String _hostAuthEndPoint = "/api/broadcasting/auth";
  final int _pusherPort = 6001;

  static Echo get instance => _echo;

  static String get socketId => _echo.socketId ?? "11111.11111111";

  LaravelEchoService({required this.token});

  @override
  void onInit() {
    Get.find<Logger>().i('Start onInit in LaravelEchoService');
    _echo = Echo(
      PusherConnector(
        _pusherAppKey,
        cluster: _pusherCluster,
        host: _hostEndPoint,
        authEndPoint: _hostAuthEndPoint,
        wsPort: _pusherPort,
        wssPort: 443,
        encrypted: true,
        activityTimeout: 120000,
        pongTimeout: 30000,
        maxReconnectionAttempts: 6,
        maxReconnectGapInSeconds: 30,
        enableLogging: true,
        autoConnect: false,
        nameSpace: 'nameSpace',
        authHeaders: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    Get.find<Logger>().f('End onInit in LaravelEchoService');
    super.onInit();
  }
}

/*

  return Echo(
    SocketIoConnector(
      'http://localhost:6001',
      namespace: 'nameSpace',
      autoConnect: false,
      authHeaders: {'Authorization': 'Bearer token'},
      moreOptions: {
        'transports': ['websocket']
      },
    ),
  );

 */
