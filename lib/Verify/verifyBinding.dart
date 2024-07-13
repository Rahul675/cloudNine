import 'package:cloudnine/Verify/verifyController.dart';
import 'package:get/get.dart';

class VerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}
