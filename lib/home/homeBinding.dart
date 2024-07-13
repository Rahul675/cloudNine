import 'package:cloudnine/home/homeController.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<LoginController>(() => LoginController());
    Get.put(LoginController(), permanent: true);
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
