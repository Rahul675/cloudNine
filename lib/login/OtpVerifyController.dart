import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/login/loginBinding.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/models/registrationRequest.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OtpVerifyController extends GetxController {
  static final StorageService storageService = StorageService.instance;


  TextEditingController phoneController = TextEditingController();
  List<TextEditingController> textPhoneControllers = [];

  late TextEditingController emailController = TextEditingController();
  List<TextEditingController> textEmailControllers = [];

  @override
  void onInit() {
    super.onInit();
   

     for (int i = 0; i < 6; i++) {
      textPhoneControllers.add(TextEditingController());
      textEmailControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  

 
}
