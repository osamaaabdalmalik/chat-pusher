import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pusher/core/constants/app_api_routes.dart';
import 'package:pusher/core/services/api_service.dart';
import 'package:pusher/features/auth/data/models/user_auth_model.dart';
import 'package:pusher/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel> register({required UserModel userModel});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserAuthModel> register({required UserModel userModel}) async {
    try {
      Get.find<Logger>().i("Start `register` in |MainRemoteDataSourceImpl|");

      Map<String, dynamic> mapData = await apiService.post(
        subUrl: AppApiRoutes.register,
        data: userModel.toJson(),
      );
      final userAuthModel = UserAuthModel.fromJson(mapData['data']);

      Get.find<Logger>().f("End `register` in |MainRemoteDataSourceImpl|");
      return Future.value(userAuthModel);
    } catch (e) {
      Get.find<Logger>().e(
        "End `register` in |MainRemoteDataSourceImpl| Exception: ${e.runtimeType}",
      );
      rethrow;
    }
  }
}
