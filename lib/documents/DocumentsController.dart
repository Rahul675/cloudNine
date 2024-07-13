import 'dart:convert';
import 'dart:io';

import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/home/homeController.dart';
import 'package:cloudnine/login/loginBinding.dart';
import 'package:cloudnine/Verify/verify_code.dart';
import 'package:cloudnine/models/registrationRequest.dart';
import 'package:cloudnine/models/usersModel.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:cloudnine/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

enum DocumentType { licence, ids, shop_photos }

class DocumentsController extends GetxController {
  RxList<FileAndType> selectedFilesWithType = <FileAndType>[].obs;

  final RxInt businessLicenseFiles = 0.obs;
  final RxInt contactPersonIdFiles = 0.obs;
  final RxInt businessPhotos = 0.obs;
  static final StorageService storageService = StorageService.instance;
  final HomeController homeController = HomeController();

  RxList userDocumentsLicence = [].obs;
  RxList userDocumentsIds = [].obs;
  RxList userDocumentsPhoto = [].obs;
 
  @override
  void onInit() {
    userData();
    super.onInit();
  }

  userData(){
    MasterDataProvider().userData();
  }

  Future<void> selectFiles(DocumentType type) async {
    /*List<File> pickedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any
    )) as List<File>;*/

    FilePickerResult? pickedFiles = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (pickedFiles != null) {
      List<File> files =
          pickedFiles.files.map((file) => File(file.path!)).toList();
      selectedFilesWithType
          .addAll(files.map((file) => FileAndType(file: file, type: type)));

      if (type == DocumentType.licence) {
        print("files---${files.length}");
        businessLicenseFiles.value = files.length;
      }
      if (type == DocumentType.ids) {
        contactPersonIdFiles.value = files.length;
      }
      if (type == DocumentType.shop_photos) {
        businessPhotos.value = files.length;
      }
    }
  }

  Future<void> uploadFiles(context) async {
    if (businessLicenseFiles.value == 0 &&
        contactPersonIdFiles.value == 0 &&
        businessPhotos.value == 0) {
      Get.snackbar(
        'Error',
        "Please select at least one document.",
        // "Something went wrong.",
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
    } else {
      String url = '${ApiService.baseUrl}/user/update-business-documents';
      Map<DocumentType, List<File>> filesByType = {};

      // Group files by document type
      for (var fileAndType in selectedFilesWithType) {
        if (!filesByType.containsKey(fileAndType.type)) {
          filesByType[fileAndType.type] = [];
        }
        filesByType[fileAndType.type]!.add(fileAndType.file);
      }

      // Upload files by document type
      String token = storageService.getToken();
      var headers = {'Authorization': 'Bearer ${token}'};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      for (var entry in filesByType.entries) {
        for (var file in entry.value) {
          if (entry.key.toString() == DocumentType.licence.toString()) {
            request.files.add(
                await http.MultipartFile.fromPath('licences[]', file.path));
          }
          if (entry.key.toString() == DocumentType.ids.toString()) {
            request.files
                .add(await http.MultipartFile.fromPath('ids[]', file.path));
          }
          if (entry.key.toString() == DocumentType.shop_photos.toString()) {
            request.files.add(
                await http.MultipartFile.fromPath('shop_photos[]', file.path));
          }
        }
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      final responseBody = await utf8.decoder
          .bind(response.stream)
          .toList(); // Convert bytes to string
      final jsonString =
          responseBody.join(); // Join all chunks into a single string
      final jsonData = json.decode(jsonString); // Parse JSON from string
      
      Get.snackbar(
        response.statusCode == 200 ? 'Success' : 'Error',
        jsonData["message"],
        // "Something went wrong.",
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );

      if (response.statusCode == 200) {
        Provider.of<MasterDataProvider>(context, listen: false).userData();
       print(jsonData!["data"]["users_business_licences"]);

        /*.value = jsonData!["data"]["users_business_licences"];
        userDocumentsIds.value = jsonData["data"]["users_business_ids"];
        userDocumentsPhoto.value = jsonData["data"]["users_business_shop_photo"];*/
       
        Get.offAllNamed(Routes.HOME);
        //print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  Future<void> deleteUploads(String type, int index, BuildContext context) async {
   var id = "";
    switch(type){
      case "licence":
        id = userDocumentsLicence[index]["id"].toString();
        userDocumentsLicence.removeAt(index);

      break;
      case "ids":
        id = userDocumentsIds[index]["id"].toString();
        userDocumentsIds.removeAt(index);
      break;
      case "photo":
          id = userDocumentsPhoto[index]["id"].toString();
          userDocumentsPhoto.removeAt(index);
      break;
    }

    var url = '${ApiService.baseUrl}/user/delete/document/$type/${id.toString()}';
    print(url);
    String token = storageService.getToken();
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse(url));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsondata = await jsonDecode(responseData);

    if (response.statusCode == 200) {
      
      userData();
      Get.snackbar(
        response.statusCode == 200 ? 'Success' : 'Error',
        jsondata["message"],
        // "Something went wrong.",
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        colorText: Colors.white,
      );
    } 
  }


}

class FileAndType {
  final File file;
  final DocumentType type;

  FileAndType({required this.file, required this.type});
}
