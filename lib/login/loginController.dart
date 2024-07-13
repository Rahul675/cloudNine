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
import 'package:provider/provider.dart';

class LoginController extends GetxController {
  static final StorageService storageService = StorageService.instance;
  RxString username = ''.obs;
  RxString password = ''.obs;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Map<String, dynamic> registeredData = {};
  late Rx<User> userData = User(
    id: 0,
    name: '',
    email: '',
    phone_number: '',
    users_business_details: {},
    users_business_licences: [],
    users_business_ids: [],
    users_business_shop_photo: [],
    users_business_specialization: [],
    users_business_social_details: [],
  ).obs;

  RxBool verifyPhone = false.obs;
  RxBool verifyEmail = false.obs;

  // User get getUserData => userData;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bus_pas_controller = TextEditingController();
  TextEditingController bus_con_pas_controller = TextEditingController();
  TextEditingController line1Controller = TextEditingController();
  TextEditingController line2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();

  void setUsername(String value) {
    username.value = value;
  }

  void setPassword(String value) {
    password.value = value;
  }

  @override
  void onInit() {
    super.onInit();
    _focusNodes = List.generate(6, (_) => FocusNode());
    // MasterDataProvider().userData();
    _controllers = [
      usernameController,
      passwordController,
      nameController,
      emailController,
      phoneController,
      bus_pas_controller,
      bus_con_pas_controller,
      line1Controller,
      line2Controller,
      zipController,
    ];
    // userData.value = User(
    //   id: 0,
    //   name: '',
    //   email: '',
    //   phone_number: '',
    //   users_business_details: {},
    //   users_business_licences: [],
    //   users_business_ids: [],
    //   users_business_shop_photo: [],
    //   users_business_specialization: [],
    //   users_business_social_details: [],
    // );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> login() async {
    try {
      var loginResponse = await ApiService.login(
        username.value,
        password.value,
      );

      if (loginResponse['success']) {
        String token = loginResponse['data']['token'];
        storageService.setToken(token);
        await MasterDataProvider().fetchMasterData();
        

        await ApiService.userDetails().then((value) async {
          
          var usersBusinessDetails = value['users_business_details'];
          if (usersBusinessDetails == null) {
            Get.offAllNamed(Routes.businessDetails);
          } else {
            Get.offAllNamed(Routes.HOME);
          }
        });
      } else {
        Get.snackbar(
          'Invalid Credentials',
          loginResponse['message'],
          backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        // "Something went wrong.",
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
    }
  }

  Future<void> registerUser() async {
    if (!_validateFields()) {
      return; 
    }

    var request = RegistrationRequest(
      name: nameController.text,
      email: emailController.text,
      password: bus_pas_controller.text,
      businessTypeId: '1',
      businessDate: '2024-04-08',
      businessAddressLine1: line1Controller.text,
      businessAddressLine2: line2Controller.text,
      cityId: '1',
      zipCode: zipController.text,
      phoneNumber: phoneController.text,
      confirmPassword: bus_con_pas_controller.text,
    );

    await ApiService.registerUser(request).then((value) => {
          value ?? Get.snackbar('Something went wrong', 'Something went wrong'),
          value['success']
              ? Get.toNamed(
                  Routes.verifyCodeScreen,
                  arguments: {'token': value['data']['token']},
                )
              : Get.snackbar(
                  'Something went wrong',
                  value['message'],
                  backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                  colorText: Colors.white,
                ),
        });
  }

  bool _validateFields() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields',
          backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          colorText: Colors.white,
        );
        return false;
      }
    }
    return true;
  }
}
