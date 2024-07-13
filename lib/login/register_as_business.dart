import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/login/RegisterController.dart';
import 'package:cloudnine/login/login.dart';
import 'package:cloudnine/login/register_as_business.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterAsBusiness extends GetView<RegisterController> {
  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime threeMonthsAgo = DateTime(now.year, now.month - 3, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: threeMonthsAgo, // Set initialDate to three months ago
      firstDate: DateTime(1900), // A very old date
      lastDate: threeMonthsAgo, // Today's date
    );

    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      controller.setBusinessDate(formattedDate);
      //controller.businessDate.value = formattedDate;
      print(formattedDate); // Use the formatted date as required
    }
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else if (!regExp.hasMatch(value)) {
      return 'Password must be at least 8 characters long, include an uppercase letter and a special character';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value != controller.passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final masterData = Provider.of<MasterDataProvider>(context).data;
    final userData = Provider.of<MasterDataProvider>(context).user;

    print("userData========> ${userData?.email}");
    print("masterData========> ${masterData?.state}");
    print("masterData========> ${masterData?.city}");

    // controller
    //     .setState(userData?.users_business?['city']['state_id'].toString());

    // controller.setCity(userData?.users_business?['city_id'].toString());

    if (controller.stateValue.value.isEmpty) {
      print('updating................${controller.cityValue.value}');
      controller.updateCityOptions(
          userData?.users_business?['city']['state_id'].toString());
    }

    if (controller.emailVerifiedAt.value.isEmpty) {
      controller.emailVerifiedAt.value = userData?.email_verified_at ?? "";
    }
    if (controller.phoneVerifiedAt.value.isEmpty) {
      controller.phoneVerifiedAt.value = userData?.phone_verified_at ?? "";
    }

    if (controller.nameController.text.isEmpty) {
      controller.nameController.text = userData?.name ?? "";
    }

    if (controller.businessTypeController.value.isEmpty) {
      controller.businessTypeController.value =
          userData?.users_business!["business_type_id"].toString() ?? "";
    }
    if (controller.emailController.text.isEmpty) {
      controller.emailController.text = userData?.email ?? "";
    }
    if (controller.phoneController.text.isEmpty) {
      controller.phoneController.text = userData?.phone_number ?? "";
    }
    if (controller.businessDate.value.isEmpty) {
      if (userData?.users_business!["business_date"] != null &&
          userData?.users_business!["business_date"] != "") {
        controller.businessDate.value = DateFormat('dd-MM-yyyy')
            .format(DateTime.parse(userData?.users_business!["business_date"]));
      }
    }

    if (controller.line1Controller.text.isEmpty) {
      controller.line1Controller.text =
          userData?.users_business!["business_address_line1"] ?? "";
    }
    if (controller.line2Controller.text.isEmpty) {
      controller.line2Controller.text =
          userData?.users_business!["business_address_line2"] ?? "";
    }
    if (controller.zipController.text.isEmpty) {
      controller.zipController.text =
          userData?.users_business!["zip_code"] ?? "";
    }
    if (controller.stateValue.value.isEmpty) {
      controller.stateValue.value =
          userData?.users_business!["city"]["state_id"].toString() ?? "";
    }
    print('cityController=====${controller.cityValue.value}');
    if (controller.cityValue.value.isEmpty) {
      controller.cityValue.value =
          userData?.users_business!["city_id"].toString() ?? "";
    }
    // controller.countryController.value = '';

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromRGBO(49, 39, 79, 1),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Text(
                      "Register as a Business",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextFormField(
                              controller: controller.nameController,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  // Get.snackbar('Validation Error',
                                  //     'Please enter Name of Business.');
                                  print('Not validate');
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name of Business",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),

                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(196, 135, 198, .3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10, top: 2, bottom: 2, right: 2),
                          child: Obx(() => DropdownButton<String>(
                                isExpanded: true,
                                value: controller
                                        .businessTypeController.value.isEmpty
                                    ? null
                                    : controller.businessTypeController.value,
                                hint: Text("Business Types"),
                                onChanged: controller.setBusinessType,
                                // Set the icon to be a dropdown arrow
                                underline: Container(), // Hide the underline
                                items: masterData?.business_types
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic value) {
                                  return DropdownMenuItem<String>(
                                    value: value["id"].toString(),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              8.0), // Add padding to separate text from icon
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(value["name"]),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              enabled: userData?.email_verified_at! == ''
                                  ? false
                                  : true,
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                            color: Color.fromRGBO(196, 135, 198, .3),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              child: DropdownButton<String>(
                                underline: Container(),
                                value: "+91",
                                onChanged: (String? newValue) {},
                                items: <String>[
                                  '+91'
                                ] // Add more country codes if needed
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                                width:
                                    10), // Add some spacing between dropdown and text field
                            Expanded(
                              child: TextField(
                                maxLength: 10,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: TextInputType.number,
                                // enabled: userData?.phone_verified_at == ''
                                //     ? false
                                //     : true,
                                enabled: true,
                                controller: controller.phoneController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone",
                                  hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                  counterText: '',
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: Obx(() => TextFormField(
                                  controller: TextEditingController(
                                      text: controller.businessDate.value
                                          .toString()),
                                  readOnly: true,
                                  onTap: () {
                                    _showDatePicker(context);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Date started",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade700),
                                  ),
                                )),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 2, bottom: 2, right: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.passwordVisible.value,
                          validator: (value) => validatePassword(value ?? ""),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.passwordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.setPasswordVisibility();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 2, bottom: 2, right: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.bus_con_pas_controller,
                          obscureText: controller.conPasswordVisible.value,
                          validator: (value) =>
                              validateConfirmPassword(value ?? ""),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(color: Colors.grey.shade700),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.conPasswordVisible.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.setConPasswordVisibility();
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Text(
                          "Registered Address",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: controller.line1Controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Line 1",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: controller.line2Controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Line 2",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                              ),
                            ),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: Obx(() => DropdownButton<String>(
                                  isExpanded: true,
                                  value:
                                      controller.countryController.value.isEmpty
                                          ? null
                                          : controller.countryController.value,
                                  hint: Text("Please choose a Country"),
                                  onChanged: controller.setCountry,
                                  // onChanged: (value) {},
                                  // Set the icon to be a dropdown arrow
                                  underline: Container(), // Hide the underline
                                  items: controller.countries
                                      .map<DropdownMenuItem<String>>(
                                        (e) => DropdownMenuItem<String>(
                                          value: e['id'],
                                          child: Text(e['name']!),
                                        ),
                                      )
                                      .toList(),
                                )),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: Obx(() => DropdownButton<String>(
                                  isExpanded: true,
                                  value: controller.stateValue.value.isEmpty
                                      ? null
                                      : controller.stateValue.value,
                                  hint: Text("Please choose a state"),
                                  onChanged: (String? selectedState) async {
                                    // Call setState method with the selected state
                                    print(selectedState);
                                    // await controller
                                    //     .updateCityOptions(selectedState!);
                                    // controller.cityController.value = '';
                                    // controller.setState(selectedState!);
                                    controller.stateValue.value =
                                        selectedState!;
                                    controller.updateCityOptions(selectedState);
                                  },
                                  // Set the icon to be a dropdown arrow
                                  underline: Container(), // Hide the underline
                                  items: masterData?.state
                                      .map<DropdownMenuItem<String>>(
                                          (dynamic value) {
                                    return DropdownMenuItem<String>(
                                      value: value["id"].toString(),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                                8.0), // Add padding to separate text from icon
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(value["state_name"]),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )),
                          ),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 2, bottom: 2, right: 2),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(196, 135, 198, .3),
                                  ),
                                ),
                              ),
                              child: Container(
                                  child: Obx(() => DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text("Please choose a city"),
                                        onChanged: (String? selectedCity) {
                                          // controller.setCity(selectedCity);
                                          controller.cityValue.value =
                                              selectedCity!;
                                        },
                                        value:
                                            controller.cityValue.value.isEmpty
                                                ? null
                                                : controller.cityValue.value,
                                        underline:
                                            Container(), // Hide the underline
                                        items: controller.cityOptions
                                            .map<DropdownMenuItem<String>>(
                                          (dynamic value) {
                                            return DropdownMenuItem<String>(
                                              value: value["id"].toString(),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        "${value["city_name"]}"),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ).toList(),
                                      )))),
                          // Add more text fields for other business details
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  // FadeInUp(
                  //   duration: Duration(milliseconds: 1700),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       color: Colors.white,
                  //       border: Border.all(
                  //         color: Color.fromRGBO(196, 135, 198, .3),
                  //       ),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Color.fromRGBO(196, 135, 198, .3),
                  //           blurRadius: 20,
                  //           offset: Offset(0, 10),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Container(
                  //           padding: EdgeInsets.only(
                  //               left: 10, top: 2, bottom: 2, right: 2),
                  //           decoration: BoxDecoration(
                  //             border: Border(
                  //               bottom: BorderSide(
                  //                 color: Color.fromRGBO(196, 135, 198, .3),
                  //               ),
                  //             ),
                  //           ),
                  //           child: TextFormField(
                  //             maxLength: 6,
                  //             enabled: true,
                  //             controller: controller.zipController,
                  //             keyboardType: TextInputType.number,
                  //             // inputFormatters: [
                  //             //   LengthLimitingTextInputFormatter(6),
                  //             // ],
                  //             validator: (value) {
                  //               if (value == null || value.length != 6) {
                  //                 return 'Zip/Pincode must be exactly 6 characters.';
                  //               }
                  //               return null;
                  //             },
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: "Zip/Pincode",
                  //               hintStyle:
                  //                   TextStyle(color: Colors.grey.shade700),
                  //               counterText: '',
                  //             ),
                  //           ),
                  //         ),
                  //         // Add more text fields for other business details
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: 10, top: 2, bottom: 2, right: 2),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              maxLength: 6,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              keyboardType: TextInputType.number,
                              // enabled: userData?.phone_verified_at == ''
                              //     ? false
                              //     : true,
                              enabled: true,
                              controller: controller.zipController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Zip/Pincode",
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade700),
                                counterText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: MaterialButton(
                      onPressed: () {
                        controller.registerUser();
                        // Get.toNamed(Routes.verifyCodeScreen);
                      },
                      color: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => LoginView()),
                          );
                        },
                        child: Text(
                          "Already have an account? Login",
                          style:
                              TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
