import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_enums.dart';
import 'package:pusher/core/helpers/get_state_from_failure.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/auth/domain/entities/user_entity.dart';
import 'package:pusher/features/auth/domain/usecases/login_use_case.dart';
import 'package:pusher/features/auth/domain/usecases/logout_use_case.dart';
import 'package:pusher/features/auth/domain/usecases/register_use_case.dart';

class AuthController extends GetxController {
  // Data
  UserAuth? userAuth;

  // States
  StateType registerState = StateType.init;
  StateType loginState = StateType.init;
  StateType logoutState = StateType.init;

  // Primitive
  String validationMessage = '';

  @override
  void onInit() {
    Get.find<Logger>().i("Start onInit AuthController");
    super.onInit();
    Get.find<Logger>().f("End onInit AuthController");
  }

  Future<void> register() async {
    Get.find<Logger>().i("Start `register` in |QuranController|");
    registerState = StateType.loading;
    update();
    RegisterUseCase registerUseCase = RegisterUseCase(Get.find());
    var result = await registerUseCase(
      user: const User(
        id: 0,
        email: 'osamaaabdalmalik@gmail.com',
        password: '123456789',
      ),
    );
    result.fold(
      (l) async {
        registerState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        registerState = StateType.init;
      },
      (r) {
        registerState = StateType.success;
        userAuth = r;
        update();
      },
    );
    Get.find<Logger>().w("End `register` in |QuranController| $registerState");
  }

  Future<void> login() async {
    Get.find<Logger>().i("Start `login` in |QuranController|");
    loginState = StateType.loading;
    update();
    LoginUseCase loginUseCase = LoginUseCase(Get.find());
    var result = await loginUseCase(
      user: const User(
        id: 0,
        email: 'osamaaabdalmalik@gmail.com',
        password: '123456789',
      ),
    );
    result.fold(
      (l) async {
        loginState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        loginState = StateType.init;
      },
      (r) {
        loginState = StateType.success;
        userAuth = r;
        update();
      },
    );
    Get.find<Logger>().w("End `login` in |QuranController| $loginState");
  }

  Future<void> logout() async {
    Get.find<Logger>().i("Start `logout` in |QuranController|");
    logoutState = StateType.loading;
    update();
    LogoutUseCase logoutUseCase = LogoutUseCase(Get.find());
    var result = await logoutUseCase();
    result.fold(
      (l) async {
        logoutState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        logoutState = StateType.init;
      },
      (r) {
        logoutState = StateType.success;
        userAuth = null;
        update();
      },
    );
    Get.find<Logger>().w("End `logout` in |QuranController| $logoutState");
  }
}
