import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeController extends GetxController {
  static final StorageService _storageservice = StorageService.instance;
  @override
  void onInit() async {
    // await MasterDataProvider().userData();
    // requestPermissions();
    // MasterDataProvider().userData();
    // MasterDataProvider().fetchMasterData();
    super.onInit();
  }

  // Future<void> requestPermissions() async {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     await Permission.storage.request();
  //   }
  // }
 
  Future<void> logout(context) async {
    try {
      await _storageservice.removeToken();
      final userProvider =
          Provider.of<MasterDataProvider>(context, listen: false);
      await userProvider.logout();
      print("LOGOUTME"); 
      Get.offNamed(Routes.LOGIN);
    } catch (e) {
      print("errrrrorrrr: $e");
    }
  }

  Future<void> documents() async {
    Get.toNamed(Routes.documents);
  }

  Future<void> companyDetails() async {
    Get.toNamed(Routes.registerAsBusiness);
  }

  Future<void> businessDetails() async {
    Get.toNamed(Routes.businessDetails, arguments: true);
  }
}
