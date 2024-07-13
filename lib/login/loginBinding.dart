import 'package:cloudnine/login/OtpVerifyController.dart';
import 'package:cloudnine/login/RegisterController.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StorageService>(() => StorageService());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
  }
}
