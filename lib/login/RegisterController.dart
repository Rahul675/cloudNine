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

class RegisterController extends GetxController {
  static final StorageService storageService = StorageService.instance;
  RxString emailVerifiedAt = ''.obs;
  RxString phoneVerifiedAt = ''.obs;

  RxString businessTypeController = ''.obs;
  RxString countryController = '1'.obs;
  RxString stateValue = ''.obs;
  RxString cityValue = ''.obs;
  RxString businessDate = ''.obs;
  RxList cityOptions = [].obs;

  List<Map<String, String>> countries = [
    {'id': '1', 'name': 'India'},
  ];

  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  TextEditingController passwordController = TextEditingController();
  // TextEditingController conPasswordController = TextEditingController();
  Map<String, dynamic> registeredData = {};
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bus_con_pas_controller = TextEditingController();
  TextEditingController line1Controller = TextEditingController();
  TextEditingController line2Controller = TextEditingController();
  TextEditingController zipController = TextEditingController();

  RxBool passwordVisible = true.obs;
  RxBool conPasswordVisible = true.obs;

  //RxList<dynamic> cities = <dynamic>[].obs;
  //var cityList = [].obs;

  void setBusinessType(String? value) {
    businessTypeController.value = value!;
  }

  Future<void> setCountry(String? value) async {
    countryController.value = value!;
    // MasterDataProvider().getCitiesByState(value!);
  }

  // void setState(String? state) {
  // stateValue.value = state ?? '';
  // cityValue.value = '';
  // updateCityOptions(state);
  // }

  Future<void> updateCityOptions(String? selectedState) async {
    try {
      final cities = ApiService.cloudnoneMaster(selectedState).then((value) {
        cityOptions.value = value['city'] ?? [];
        print("cityOptions=====${cityOptions.value}");
      });
    } catch (e) {
      throw Exception('Failed to get city data: $e');
    }
  }

  void setCity(String? value) {
    cityValue.value = value ?? '';
  }

  void setBusinessDate(String? value) {
    businessDate.value = value!;
  }

  setPasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  setConPasswordVisibility() {
    conPasswordVisible.value = !conPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
    // updateCityOptions(state);

    _focusNodes = List.generate(6, (_) => FocusNode());

    _controllers = [
      nameController,
      emailController,
      phoneController,
      zipController,
    ];

    if (emailVerifiedAt.value.isNotEmpty && phoneVerifiedAt.value.isNotEmpty) {
      _controllers.add(passwordController);
      _controllers.add(bus_con_pas_controller);
    }
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

  Future<void> registerUser() async {
    if (!_validateFields()) {
      return;
    }

    if (passwordController.text.isNotEmpty &&
        bus_con_pas_controller.text.isNotEmpty) {
      if (passwordController.text != bus_con_pas_controller.text) {
        Get.snackbar(
          'Validation Error',
          'Password and Confirm Password should be match.',
          backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          colorText: Colors.white,
        );
        return;
      }

      if (passwordController.text.length < 8 ||
          !RegExp(r'(?=.*[A-Z])(?=.*[!@#$%^&*])')
              .hasMatch(passwordController.text)) {
        Get.snackbar(
          'Validation Error',
          'Password should be at least 8 characters long and contain at least one uppercase letter and one special character.',
          backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          colorText: Colors.white,
        );
        return;
      }
    }

    if (phoneController.text.length != 10) {
      Get.snackbar(
        'Validation Error',
        'Phone number should be 10 digits.',
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
      return;
    }

    if (zipController.text.length != 6) {
      Get.snackbar(
        'Validation Error',
        'Zip/Pincode should be 6 digits.',
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
      return;
    }

    bool isValid =
        RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
            .hasMatch(emailController.text);
    if (!isValid) {
      Get.snackbar(
        'Validation Error',
        'Email is not valid.',
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
      return;
    }

    var request = RegistrationRequest(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      businessTypeId: businessTypeController.value,
      businessDate: businessDate.value,
      businessAddressLine1: line1Controller.text,
      businessAddressLine2: line2Controller.text,
      cityId: cityValue.value,
      zipCode: zipController.text,
      phoneNumber: phoneController.text,
      confirmPassword: bus_con_pas_controller.text,
    );

    await ApiService.registerUser(request).then((value) => {
          if (value['success'])
            {
              Get.snackbar(
                'Success',
                value['message'],
                backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                colorText: Colors.white,
              ),
              if (emailVerifiedAt.value.isNotEmpty &&
                  phoneVerifiedAt.value.isNotEmpty)
                {
                  emailVerifiedAt.value = '',
                  phoneVerifiedAt.value = '',
                  nameController.text = '',
                  businessTypeController.value = '',
                  emailController.text = '',
                  phoneController.text = '',
                  businessDate.value = '',
                  line1Controller.text = '',
                  line2Controller.text = '',
                  zipController.text = '',
                  countryController.value = '',
                  stateValue.value = '',
                  cityValue.value = '',
                  Get.offAndToNamed(Routes.HOME)
                }
              else
                {
                  Get.offAndToNamed(
                    Routes.verifyCodeScreen,
                    arguments: {'token': value['data']['token']},
                  )
                }
            }
          else
            {
              Get.snackbar(
                'Something went wrong',
                value['message'],
                backgroundColor: Color.fromRGBO(49, 39, 79, 1),
                colorText: Colors.white,
              )
            }
        });
  }

  bool _validateFields() {
    print(phoneController.text);
    print(zipController.text);
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please fill all required fields',
          backgroundColor: Color.fromRGBO(0, 0, 1, 1),
          colorText: Colors.white,
        );
        return false;
      }
    }
    return true;
  }
}
