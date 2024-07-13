// import 'package:cloudnine/home/homeController.dart';
// import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:get/get.dart';

import '../routes.dart';
import '../services/api_service.dart';

class SplashScreenController extends GetxController {
  // LoginController homeController = LoginController();
  final StorageService storageService = StorageService.instance;
  String? token;

  @override
  void onInit() {
    super.onInit();
    MasterDataProvider().userData();
    getTokenAndNavigate();
  }

  Future<void> getTokenAndNavigate() async {
    token = await StorageService.instance.getToken();
    print(token);
    if (token != null && token!.isNotEmpty) {
      print("token:  ===>>>>" + token!);
      await ApiService.userDetails().then((value) async {
        print("token ${storageService.getToken()}");
        var usersBusinessDetails = value['users_business_details'];
        var usersBusinessLicences = value['users_business_licences'];
        var usersBusinessIds = value['users_business_ids'];
        var usersBusinessShopPhoto = value['users_business_shop_photo'];

        if (usersBusinessDetails == null) {
          Get.offAllNamed(Routes.businessDetails);
        } else {
          Get.offNamed(Routes.HOME);
        }
      });
      // Get.offNamed('/home');
    } else {
      print("token: ===>" + token.toString());
      Get.offNamed('/login');
    }
  }
}
