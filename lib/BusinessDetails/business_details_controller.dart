import 'dart:convert';

import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/models/businessDetails.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDetailsController extends GetxController {
  static final StorageService storageService = StorageService.instance;
  final loginController = Get.find<LoginController>();

  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();
  final TextEditingController employeesController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController socialUrlsController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final List<String> radiusCovered = ['10', '50', '100', '200', '34'];
  final List<String> numberOfEmployees = [
    '2',
    '10',
    '50',
    '100',
    '200',
    'More'
  ];
  List<String>? selectedSpecialization;
  String? selectedSpecializationValue;
  String? selectedCityOfBusiness;
  String? selectedRadius;
  String? selectedNumberOFEmployees;
  String? selectedDesignation;
  List<SocialMedia>? selectedSocialUrls;

  // List of text editing controllers for social URLs
  final List<TextEditingController> socialUrlsControllers = [
    TextEditingController()
  ];

  // List of text editing controllers for specialization
  final List<TextEditingController> specializationsControllers = [
    TextEditingController()
  ];

  RxBool isBusinessDone = false.obs;

  setBusinessDetails(licence, ids, photo) {
    if (licence == 0 && ids == 0 && photo == 0) {
      isBusinessDone.value = true;
    }
  }

  void addSpecialization(String specialization) {
    if (selectedSpecialization == null) {
      selectedSpecialization = [specialization];
    } else if (!selectedSpecialization!.contains(specialization)) {
      selectedSpecialization!.add(specialization);
    }
    print(selectedSpecialization);
  }

  void addCities(String city) {
    if (selectedCityOfBusiness == null) {
      selectedCityOfBusiness = city;
    } else if (!selectedCityOfBusiness!.contains(city)) {
      selectedCityOfBusiness = city;
    }
    print(selectedCityOfBusiness);
  }

  void addDesignation(String designation) {
    if (selectedDesignation == null) {
      selectedDesignation = designation;
    } else if (!selectedDesignation!.contains(designation)) {
      selectedDesignation = designation;
    }
    print(selectedDesignation);
  }

  void addUrls(SocialMedia url) {
    if (selectedDesignation == null) {
      selectedSocialUrls = [url];
    } else if (!selectedSocialUrls!.contains(url)) {
      selectedSocialUrls!.add(url);
    }
    print(selectedSocialUrls);
  }

  @override
  void onInit() async {
    // await MasterDataProvider().fetchMasterData();
    super.onInit();
  }

  final urlRegExp = RegExp(
    r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$',
    caseSensitive: false,
  );

  Future<void> businessDetails() async {
    try {
      // Get the token from the storage service
      String token = storageService.getToken() ?? '';

      List<SocialMedia> socialUrls = [];
      RxBool validUrl = true.obs;
      // for (var controller in socialUrlsControllers) {
      //   String url = controller.text;
      //   if (url.isNotEmpty) {
      //     socialUrls.add(SocialMedia(name: 'social', url: url));
      //   }
      // }
      for (var controller in socialUrlsControllers) {
        String url = controller.text;
        if (url.isNotEmpty) {
          if (!urlRegExp.hasMatch(url)) {
            validUrl.value = false;
            print('Error: Invalid URL - $url');
          }
          socialUrls.add(SocialMedia(name: 'social', url: url));
        }
      }
      if (!validUrl.value) {
        Get.snackbar(
          'Validation Error',
          'Invalid Social urls',
          backgroundColor: Color.fromRGBO(49, 39, 79, 1),
          colorText: Colors.white,
        );
        return;
      }

      // Check if the token is valid
      if (token.isEmpty) {
        print('Error: Token is empty or null');
        return;
      }

      // Check if required values are null
      if (selectedCityOfBusiness == null ||
          selectedRadius == null ||
          selectedNumberOFEmployees == null ||
          selectedDesignation == null) {
        print('Error: Some required values are null');
        return;
      }

      // Create a BusinessDetailsModel object and populate it with controller values
      BusinessDetailsModel businessDetailsModel = BusinessDetailsModel(
        specialization: selectedSpecialization!,
        cityId: selectedCityOfBusiness!,
        radiusCoverage: selectedRadius!,
        numberOfEmployees: selectedNumberOFEmployees!,
        contactPersonName: nameController.text,
        designationId: selectedDesignation!,
        social: socialUrls ?? [],
        websiteUrl: websiteController.text,
      );

      print("businessDetailsModel" + businessDetailsModel.toJson());

      // Call the ApiService method to send the request
      await ApiService.businessDetails(token, businessDetailsModel)
          .then((value) {
        if (value) {
          print('valuevalue:' + value.toString());
          Get.offAllNamed(Routes.documents);
        }
      });
    } catch (e) {
      // Handle errors here
      print('Error: $e');
    }
  }
}
