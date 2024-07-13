import 'package:animate_do/animate_do.dart';
import 'package:cloudnine/BusinessDetails/business_details_controller.dart';
import 'package:cloudnine/DataProvider/master.dart';

import 'package:cloudnine/login/login.dart';
import 'package:cloudnine/login/register_as_business.dart';
import 'package:cloudnine/auth/upload_documents.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class BusinessDetails extends GetView<BusinessDetailsController> {
  var showBackButton;

  BusinessDetails({super.key, required this.showBackButton});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // MasterDataProvider().fetchMasterData();
    var dataProvider = Provider.of<MasterDataProvider>(context).user;
    var masterDataProvider = Provider.of<MasterDataProvider>(context).data;

    // print("city====>${masterDataProvider.city}");
    // print("designation====>${masterDataProvider.designation}");
    // print("specialization====>${masterDataProvider?.specialization}");
    // print("specialization====>${masterDataProvider?.city}");
    // print("designation====>${masterDataProvider?.designation}");
    // print("designation====>${dataProvider.users_business_details}");

    if (dataProvider != null) {
      controller.selectedRadius =
          dataProvider!.users_business_details['radius_coverage'];
      controller.selectedCityOfBusiness =
          dataProvider!.users_business_details['city_id'].toString();
      controller.selectedNumberOFEmployees = dataProvider!
          .users_business_details['number_of_employees']
          .toString();
      controller.nameController.text = dataProvider!
          .users_business_details['contact_person_name']
          .toString();
      controller.selectedDesignation =
          dataProvider!.users_business_details['designation_id'].toString();
      controller.websiteController.text =
          dataProvider!.users_business_details['website_url'].toString();
    }
    // var cities = masterDataProvider.city!;
    // List<String> cities = [];
    List<Map<String, String>>? cityIds = [];
    List<Map<String, String>>? designationIds = [];
    List<String>? specializations = [];
    List<Map<String, String>> specializationIds = [];
    if (masterDataProvider != null) {
      for (var data in masterDataProvider.city) {
        // cities.add(data['city_name']);
        cityIds.add({'id': data['id'].toString(), 'name': data['city_name']});
      }
      // List<String> designations = [];

      for (var data in masterDataProvider.designation) {
        // designations.add(data['name']);
        designationIds.add({'id': data['id'].toString(), 'name': data['name']});
      }

      for (var data in masterDataProvider.specialization) {
        specializations.add(data['name']);
        specializationIds
            .add({'id': data['id'].toString(), 'name': data['name']});
      }
    }
    if (dataProvider != null) {
      controller.setBusinessDetails(
          dataProvider?.users_business_licences!.length,
          dataProvider?.users_business_ids.length,
          dataProvider?.users_business_shop_photo.length);
    }

    // print(masterDataProvider.city);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // Conditionally show the back button based on the parameter
        leading: showBackButton
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color.fromRGBO(49, 39, 79, 1),
                ),
              )
            : Container(), // Set to null if back button shouldn't be shown
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
                      "Business Details",
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
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.specializationsControllers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FadeInUp(
                                      duration: Duration(milliseconds: 1700),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                196, 135, 198, .3),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                  196, 135, 198, .3),
                                              blurRadius: 20,
                                              offset: Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            DropdownButtonFormField<String>(
                                              hint: Text("Specialization"),
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 0,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                              items: specializations
                                                  .map((String data) {
                                                return DropdownMenuItem<String>(
                                                  value: data,
                                                  child: Text(data),
                                                );
                                              }).toList(),
                                              onChanged: (String? value) {
                                                controller.addSpecialization(
                                                    specializationIds
                                                        .firstWhere((element) =>
                                                            element['name'] ==
                                                            value)['id']!);
                                                controller
                                                        .selectedSpecializationValue =
                                                    value;
                                              },
                                              value: controller
                                                  .selectedSpecializationValue,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  index ==
                                              controller
                                                      .specializationsControllers
                                                      .length -
                                                  1 &&
                                          controller.specializationsControllers
                                                  .length <
                                              5
                                      ? CircleAvatar(
                                          child: IconButton(
                                            onPressed: () {
                                              controller
                                                  .specializationsControllers
                                                  .add(TextEditingController());
                                              Get.forceAppUpdate();
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        )
                                      // Show minus button if there is more than one item
                                      : controller.specializationsControllers
                                                  .length >
                                              1
                                          ? CircleAvatar(
                                              child: IconButton(
                                                onPressed: () {
                                                  controller
                                                      .specializationsControllers
                                                      .removeAt(index);
                                                  Get.forceAppUpdate();
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                            )
                                          // Otherwise, show an empty container
                                          : Container(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
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
                  //         DropdownButtonFormField<String>(
                  //           hint: Text("Specialization"),
                  //           decoration: InputDecoration(
                  //             contentPadding: EdgeInsets.symmetric(
                  //               horizontal: 10,
                  //               vertical: 0,
                  //             ),
                  //             border: InputBorder.none,
                  //           ),
                  //           items: specializations.map((String data) {
                  //             return DropdownMenuItem<String>(
                  //               value: data,
                  //               child: Text(data),
                  //             );
                  //           }).toList(),
                  //           onChanged: (String? value) {
                  //             // Set the selected specialization
                  //             controller.selectedSpecialization = value;
                  //           },
                  //           value: controller.selectedSpecialization,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          DropdownButtonFormField<String>(
                            hint: Text("City of business"),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              border: InputBorder.none,
                            ),
                            items: cityIds.map((Map<String, String> city) {
                              return DropdownMenuItem<String>(
                                value: city['id'],
                                child: Text("${city['name']}"),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              controller.addCities(value!);

                              controller.selectedCityOfBusiness = value;
                              print(controller.selectedCityOfBusiness);
                            },
                            value: controller.selectedCityOfBusiness,
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
                          DropdownButtonFormField<String>(
                            hint: Text("Radius covered"),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              border: InputBorder.none,
                            ),
                            // items: [],
                            items:
                                controller.radiusCovered.map((String radius) {
                              return DropdownMenuItem<String>(
                                value: radius,
                                child: Text(radius),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              // Set the selected specialization
                              controller.selectedRadius = value;
                            },
                            value: controller.selectedRadius,
                            // value: dataProvider!
                            //     .users_business_details['radius_coverage']
                            //     .toString(),
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
                          DropdownButtonFormField<String>(
                            hint: Text("Number of employees"),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              border: InputBorder.none,
                            ),
                            // items: [],
                            items: controller.numberOfEmployees
                                .map((String numberOfEmployees) {
                              return DropdownMenuItem<String>(
                                value: numberOfEmployees,
                                child: Text(numberOfEmployees),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              // Set the selected specialization
                              controller.selectedNumberOFEmployees = value;
                            },
                            value: controller.selectedNumberOFEmployees,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Text(
                          "Contact Person",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                              controller: controller.nameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name",
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
                          DropdownButtonFormField<String>(
                            hint: Text("Designation"),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              border: InputBorder.none,
                            ),
                            // items: designationIds
                            //     .map((Map<String, String> designation) {
                            //   return DropdownMenuItem<String>(
                            //     value: designation['id'],
                            //     child: Text("${designation['name']}"),
                            //   );
                            // }).toList(),
                            // onChanged: (String? value) {
                            //   // Set the selected specialization
                            //   controller.addDesignation(value!);
                            // },
                            // value: controller.selectedDesignation,
                            items: designationIds
                                .map((Map<String, String> designation) {
                              return DropdownMenuItem<String>(
                                value: designation['id'],
                                child: Text("${designation['name']}"),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              controller.addDesignation(value!);
                            },
                            value: controller.selectedDesignation,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
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
                  //           child: TextField(
                  //             controller: socialUrlsController,
                  //             decoration: InputDecoration(
                  //               border: InputBorder.none,
                  //               hintText: "Social urls",
                  //               hintStyle:
                  //                   TextStyle(color: Colors.grey.shade700),
                  //             ),
                  //           ),
                  //         ),
                  //         // Add more text fields for other business details
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, top: 10),
                          child: Text(
                            "Social urls",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.socialUrlsControllers.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          top: 2,
                                          bottom: 2,
                                          right: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(196, 135, 198, .3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                196, 135, 198, .3),
                                            blurRadius: 20,
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: TextFormField(
                                        controller: controller
                                            .socialUrlsControllers[index],
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "URL ${index + 1}",
                                          hintStyle: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                        // validator: urlValidator,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  index ==
                                              controller.socialUrlsControllers
                                                      .length -
                                                  1 &&
                                          controller.socialUrlsControllers
                                                  .length <
                                              5
                                      ? CircleAvatar(
                                          child: IconButton(
                                            onPressed: () {
                                              controller.socialUrlsControllers
                                                  .add(TextEditingController());
                                              Get.forceAppUpdate();
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        )
                                      // Show minus button if there is more than one item
                                      : controller.socialUrlsControllers
                                                  .length >
                                              1
                                          ? CircleAvatar(
                                              child: IconButton(
                                                onPressed: () {
                                                  controller
                                                      .socialUrlsControllers
                                                      .removeAt(index);
                                                  Get.forceAppUpdate();
                                                },
                                                icon: Icon(Icons.remove),
                                              ),
                                            )
                                          // Otherwise, show an empty container
                                          : Container(),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
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
                            child: TextField(
                              controller: controller.websiteController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Website",
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
                    height: 30,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: MaterialButton(
                      onPressed: () {
                        controller.businessDetails();
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (_) => UploadDocuments()),
                        // );
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
                    height: 20,
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
