import 'package:pusher/features/quran/data/data_sources/quran_remote_data_source.dart';
import 'package:pusher/features/quran/data/repository/quran_repo_impl.dart';
import 'package:pusher/features/quran/domain/repository/quran_repo.dart';
import 'package:get/get.dart';

class QuranBindings extends Bindings {
  @override
  dependencies() async {
    Get.put<QuranRemoteDataSource>(
      QuranRemoteDataSourceImpl(apiService: Get.find()),
    );
    Get.put<QuranRepo>(
      QuranRepoImpl(quranRemoteDataSource: Get.find()),
    );

//    Get.put(GetCategoriesAsPairUseCase(Get.find()));
//    Get.put(MainController());
  }
}
