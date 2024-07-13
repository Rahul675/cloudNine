import 'dart:convert';
import 'package:cloudnine/models/businessDetails.dart';
import 'package:cloudnine/models/registrationRequest.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String imageURL =
      'http://165.22.215.103/projects/cloud9/public/';
  static const String baseUrl =
      'http://165.22.215.103/projects/cloud9/public/api';

  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login'));
      request.fields.addAll({
        'email': email,
        'password': password,
      });

      final response = await request.send();
      final String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        return jsonResponse;
      } else {
        return jsonDecode(responseBody);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> registerUser(
      RegistrationRequest request) async {
    var url = Uri.parse('$baseUrl/registration');

    try {
      var response = await http.post(
        url,
        body: jsonEncode(request.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print("jsonResponse: ==>$jsonResponse");
        return jsonResponse;
      } else {
        print('Failed to register: ${response.reasonPhrase}');
        throw Exception('Failed to register: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Exception during registration: $e');
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> cloudMaster() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cloudnone-master'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        print("response===>${jsonDecode(response.body)}");
        return jsonDecode(response.body);
        // Master(business_types: jsonResponse["business_types"], designation: jsonResponse["designation"], specialization: jsonResponse["specialization"], state: jsonResponse["state"]);
      } else {
        throw Exception('Failed to get data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> cloudnoneMaster(city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/cloudnone-master?state_id=${city.toString()}'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
        // Master(business_types: jsonResponse["business_types"], designation: jsonResponse["designation"], specialization: jsonResponse["specialization"], state: jsonResponse["state"]);
      } else {
        throw Exception('Failed to get data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  static Future<bool> emailAndPhoneVerify(
      String token, String otp, String type) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/verify/otp/$type'));
      request.fields.addAll({'otp': otp});

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print(responseData);
        var decodedResponse = jsonDecode(responseData);
        if (decodedResponse['success'] == true) {
          Get.snackbar(
            'Success',
            decodedResponse['message'],
            backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
            colorText: Colors.white,
          );
          return decodedResponse['success'];
        } else {
          Get.snackbar(
            'Error',
            decodedResponse['message'],
            backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
            colorText: Colors.white,
          );
          return decodedResponse['success'];
        }
      } else {
        Get.snackbar(
          'OTP Verification Failed',
          'Please try again later',
          backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Map<String, dynamic>> userDetails() async {
    try {
      final StorageService storageService = StorageService.instance;
      var headers = {'Authorization': 'Bearer ${storageService.getToken()}'};
      var url = '$baseUrl/user';
      print("10_user_user_user_${url}");
      print(headers);
      var request = http.Request('GET', Uri.parse(url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseData);
      } else {
        print(responseData);

        throw Exception('Failed to get data: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> businessDetails(
      String token, BusinessDetailsModel businessDetailsModel) async {
    var socialUrls = jsonDecode(businessDetailsModel.toJson());
    var social = jsonEncode(socialUrls['social']);
    print("10convertedList${social}");

    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/user/update-business-details'));
      request.fields.addAll({
        'specialization': businessDetailsModel.specialization.toString(),
        'radius_coverage': businessDetailsModel.radiusCoverage,
        'city_id': businessDetailsModel.cityId,
        'number_of_employees': businessDetailsModel.numberOfEmployees,
        'contact_person_name': businessDetailsModel.contactPersonName,
        'designation_id': businessDetailsModel.designationId,
        'website_url': businessDetailsModel.websiteUrl,
        'social': social.toString(),
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = await response.stream.bytesToString();
        var jsonData = jsonDecode(jsonResponse);
        if (jsonData['success']) {
          Get.snackbar(
            'Success',
            jsonData['message'],
            backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
            colorText: Colors.white,
          );
          return jsonData['success'];
        } else {
          Get.snackbar(
            'Error',
            jsonData['message'],
            backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
            colorText: Colors.white,
          );
          return jsonData['success'];
        }
      } else {
        print("response===>${response.reasonPhrase}");
        Get.snackbar(
          'Something went wrong',
          response.reasonPhrase.toString(),
          backgroundColor: Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static List<Map<String, dynamic>> convertToJsonList(String jsonString) {
    // Parse JSON string to a list of strings
    List<String> stringList = json.decode(jsonString).cast<String>();

    // Initialize an empty list to store converted maps
    List<Map<String, dynamic>> mapList = [];

    // Remove escape characters from each string and parse it to a map
    for (String str in stringList) {
      // Remove escape characters
      String unescapedStr = str.replaceAll(r'\"', '"');

      // Parse to map
      Map<String, dynamic> map = json.decode(unescapedStr);
      mapList.add(map);
    }

    return mapList;
  }

  // static Future<Map<String, dynamic>> postData(
  //     Map<String, dynamic> data) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/post'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(data),
  //   );

  //   if (response.statusCode == 201) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to post data');
  //   }
  // }
}
