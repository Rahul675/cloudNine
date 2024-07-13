import 'package:cloudnine/BusinessDetails/business_details.dart';
import 'package:cloudnine/BusinessDetails/business_details_binding.dart';
import 'package:cloudnine/documents/documents.dart';
import 'package:cloudnine/documents/documentsBinding.dart';
import 'package:cloudnine/home/homeBinding.dart';
import 'package:cloudnine/login/login.dart';
import 'package:cloudnine/login/register_as_business.dart';
import 'package:cloudnine/auth/upload_documents.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/home/home.dart';
import 'package:cloudnine/login/loginBinding.dart';
import 'package:cloudnine/splash/splashBinding.dart';
import 'package:cloudnine/splash/splashScreen.dart';
import 'package:get/get.dart';

import 'Verify/verifyBinding.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.registerAsBusiness,
      page: () => RegisterAsBusiness(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.verifyCodeScreen,
      page: () => VerifyCodeScreen(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: Routes.businessDetails,
      page: () => BusinessDetails(
        showBackButton: Get.arguments ?? false,
      ),
      binding: BusinessDetailsBinding(),
    ),
    GetPage(
      name: Routes.documents,
      page: () => DocumentsView(),
      binding: DocumentsBinding(),
    ),
  ];
}

abstract class Routes {
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const documents = '/documents';
  static const registerAsBusiness = '/register_as_business';
  static const businessDetails = '/business_details';
  static const verifyCodeScreen = '/verify_code';
  static const uploadDocuments = '/upload_documents';
}
