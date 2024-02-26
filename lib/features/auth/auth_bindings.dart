import 'package:get/get.dart';
import 'package:pusher/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pusher/features/auth/data/repository/auth_repo_impl.dart';
import 'package:pusher/features/auth/domain/repository/auth_repo.dart';

class AuthBindings extends Bindings {
  @override
  dependencies() async {
    Get.put<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(apiService: Get.find()),
    );
    Get.put<AuthRepo>(
      AuthRepoImpl(authRemoteDataSource: Get.find()),
    );

//    Get.put(GetCategoriesAsPairUseCase(Get.find()));
//    Get.put(MainController());
  }
}
