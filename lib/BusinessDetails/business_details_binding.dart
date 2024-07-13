import 'package:cloudnine/BusinessDetails/business_details_controller.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:get/get.dart';

class BusinessDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusinessDetailsController>(() => BusinessDetailsController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
