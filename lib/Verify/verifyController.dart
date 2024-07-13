import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/login/loginBinding.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/models/registrationRequest.dart';
import 'package:cloudnine/models/usersModel.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyController extends GetxController {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  RxBool verifyPhone = false.obs;
  RxBool verifyEmail = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  // @override
  // void dispose() {
  //   for (var node in _focusNodes) {
  //     node.dispose();
  //   }
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  // bool _validateFields() {
  //   for (var controller in _controllers) {
  //     if (controller.text.isEmpty) {
  //       Get.snackbar(
  //         'Validation Error',
  //         'Please fill all required fields',
  //         backgroundColor: Color.fromRGBO(49, 39, 79, 1),
  //         colorText: Colors.white,
  //       );
  //       return false;
  //     }
  //   }
  //   return true;
  // }
}
