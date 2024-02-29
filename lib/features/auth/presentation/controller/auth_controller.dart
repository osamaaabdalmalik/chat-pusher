import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_enums.dart';
import 'package:pusher/core/constants/app_keys.dart';
import 'package:pusher/core/constants/app_pages_routes.dart';
import 'package:pusher/core/helpers/get_state_from_failure.dart';
import 'package:pusher/core/services/easy_loader_service.dart';
import 'package:pusher/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:pusher/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pusher/features/auth/data/repository/auth_repo_impl.dart';
import 'package:pusher/features/auth/domain/entities/user_auth_entity.dart';
import 'package:pusher/features/auth/domain/entities/user_entity.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';
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
  void onInit() async {
    Get.find<Logger>().i("Start onInit AuthController");
    super.onInit();
    Get.find<Logger>().w("End onInit AuthController");
  }

  Future<bool> register({required SignupData signupData}) async {
    Get.find<Logger>().i("Start `register` in |QuranController|");
    registerState = StateType.loading;
    update();
    RegisterUseCase registerUseCase = RegisterUseCase(Get.find());
    var result = await registerUseCase(
      user: User(
        id: 0,
        email: signupData.name!,
        password: signupData.password!,
      ),
    );
    return result.fold(
      (l) async {
        registerState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        registerState = StateType.init;
        Get.find<Logger>().w("End `register` in |QuranController| $registerState");
        return false;
      },
      (r) {
        registerState = StateType.success;
        userAuth = r;
        update();
        Get.offNamed(AppPagesRoutes.chatsScreen, arguments: {AppKeys.user: r});
        Get.find<Logger>().w("End `register` in |QuranController| $registerState");
        return true;
      },
    );
  }

  Future<bool> login({required LoginData loginData}) async {
    Get.find<Logger>().i("Start `login` in |QuranController|");
    loginState = StateType.loading;
    update();
    LoginUseCase loginUseCase = LoginUseCase(Get.find());
    var result = await loginUseCase(
      user: User(
        id: 0,
        email: loginData.name,
        password: loginData.password,
      ),
    );
    return result.fold(
      (l) async {
        loginState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        loginState = StateType.init;
        Get.find<Logger>().w("End `login` in |QuranController| $loginState");
        return false;
      },
      (r) {
        loginState = StateType.success;
        userAuth = r;
        update();
        Get.offNamed(AppPagesRoutes.chatsScreen, arguments: {AppKeys.user: r});
        Get.find<Logger>().w("End `login` in |QuranController| $loginState");
        return true;
      },
    );
  }

  Future<bool> logout() async {
    Get.find<Logger>().i("Start `logout` in |QuranController|");
    logoutState = StateType.loading;
    update();
    EasyLoaderService.showLoading();
    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(apiService: Get.find()),
    );
    Get.put<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(sharedPreferencesService: Get.find()),
    );
    Get.put<AuthRepo>(
      AuthRepoImpl(
        authRemoteDataSource: Get.find(),
        authLocalDataSource: Get.find(),
      ),
    );
    LogoutUseCase logoutUseCase = LogoutUseCase(Get.find());
    var result = await logoutUseCase();
    return result.fold(
      (l) async {
        logoutState = getStateFromFailure(l);
        validationMessage = l.message;
        update();
        await Future.delayed(const Duration(milliseconds: 50));
        logoutState = StateType.init;
        EasyLoaderService.showError(message: validationMessage);
        Get.find<Logger>().w("End `logout` in |QuranController| $logoutState");
        return false;
      },
      (r) {
        logoutState = StateType.success;
        userAuth = null;
        update();
        EasyLoaderService.dismiss();
        Get.offAllNamed(AppPagesRoutes.authScreen);
        Get.find<Logger>().w("End `logout` in |QuranController| $logoutState");
        return true;
      },
    );
  }
}
