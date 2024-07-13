import 'package:cloudnine/home/homeController.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:cloudnine/splash/splashController.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    // Bind StorageService
    Get.lazyPut<StorageService>(() => StorageService());

    // Bind SplashScreenController
    Get.put<SplashScreenController>(
      SplashScreenController(),
    );
    Get.put<LoginController>(
      LoginController(),
    );
  }
}
