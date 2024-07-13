import 'package:animate_do/animate_do.dart';
import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/documents/DocumentsController.dart';
import 'package:cloudnine/models/usersModel.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class DocumentsView extends GetView<DocumentsController> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MasterDataProvider>(context).user;
    
    if(dataProvider != null){
       controller.userDocumentsLicence.value =
        dataProvider!.users_business_licences!;
    controller.userDocumentsIds.value = dataProvider.users_business_ids;
    controller.userDocumentsPhoto.value =
        dataProvider.users_business_shop_photo;
    }
   

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(49, 39, 79, 1),
        centerTitle: true,
        title: FadeInUp(
          duration: Duration(milliseconds: 1500),
          child: Text(
            "Documents",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
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
                  SizedBox(
                    height: 30,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Business License"),
                              InkWell(
                                onTap: () async {
                                  controller.selectFiles(DocumentType.licence);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  (controller.selectedFilesWithType.length / 3)
                                      .ceil(),
                              itemBuilder: (BuildContext context, int index) {
                                return Wrap(
                                  spacing: 8.0,
                                  children: List.generate(3, (innerIndex) {
                                    final itemIndex = index * 3 + innerIndex;
                                    if (itemIndex <
                                            controller
                                                .selectedFilesWithType.length &&
                                        controller
                                                .selectedFilesWithType[
                                                    itemIndex]
                                                .type ==
                                            DocumentType.licence) {
                                      return SizedBox(
                                        width: (MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                32.0) /
                                            4, // Adjust the width as needed considering borders and margins
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors
                                                      .black, // Change the color of the border as needed
                                                  width:
                                                      1.0, // Adjust the width of the border as needed
                                                ),
                                              ),
                                              child: Image.file(
                                                controller
                                                    .selectedFilesWithType[
                                                        itemIndex]
                                                    .file,
                                                fit: BoxFit.contain,
                                                height: 100,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller
                                                .selectedFilesWithType.removeAt(index);
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                );
                              },
                            ),
                          ),
                          Obx(() => GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemCount: controller.userDocumentsLicence!.length ==
                                        null
                                    ? 0
                                    : controller.userDocumentsLicence!.length,
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Image.network(
                                            '${ApiService.imageURL}licences/${controller.userDocumentsLicence[rowIndex]["licence"]}',
                                            fit: BoxFit.contain,
                                            height: 100,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.deleteUploads(
                                                'licence', rowIndex, context);
                                            // controller.removeSelectedFile(rowIndex);
                                          },
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Contact Person ID"),
                              InkWell(
                                onTap: () async {
                                  controller.selectFiles(DocumentType.ids);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    (controller.selectedFilesWithType.length /
                                            3)
                                        .ceil(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Wrap(
                                    spacing:
                                        8.0, // Adjust the spacing between items as needed
                                    children: List.generate(3, (innerIndex) {
                                      final itemIndex = index * 3 + innerIndex;
                                      if (itemIndex <
                                              controller.selectedFilesWithType
                                                  .length &&
                                          controller
                                                  .selectedFilesWithType[
                                                      itemIndex]
                                                  .type ==
                                              DocumentType.ids) {
                                        return SizedBox(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  32.0) /
                                              4, // Adjust the width as needed considering borders and margins
                                          child: Stack(
                                            children: [
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                      onTap: () {
                                                        print(
                                                            'licence clikedd....$innerIndex,$index');
                                                      },
                                                      child:
                                                          Icon(Icons.cancel))),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors
                                                        .black, // Change the color of the border as needed
                                                    width:
                                                        1.0, // Adjust the width of the border as needed
                                                  ),
                                                ),
                                                child: Image.file(
                                                  controller
                                                      .selectedFilesWithType[
                                                          itemIndex]
                                                      .file,
                                                  fit: BoxFit.contain,
                                                  height: 100,
                                                ),
                                              ),

                                              InkWell(
                                              onTap: () {
                                                controller
                                                .selectedFilesWithType.removeAt(index);
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                  );
                                },
                              )),
                           Obx(() => GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemCount: controller.userDocumentsIds!.length ==
                                        null
                                    ? 0
                                    : controller.userDocumentsIds!
                                        .length, // Number of items in each row
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors
                                            .black, // Change the color of the border as needed
                                        width:
                                            1.0, // Adjust the width of the border as needed
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image.network(
                                            '${ApiService.imageURL}ids/${controller.userDocumentsIds[rowIndex]["ids"]}',
                                            fit: BoxFit.contain,
                                            height: 100,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.deleteUploads(
                                                "ids", rowIndex, context);
                                          },
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              
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
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Business/Shop Photos"),
                              InkWell(
                                onTap: () async {
                                  controller
                                      .selectFiles(DocumentType.shop_photos);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Upload',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    (controller.selectedFilesWithType.length /
                                            3)
                                        .ceil(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Wrap(
                                    spacing:
                                        8.0, // Adjust the spacing between items as needed
                                    children: List.generate(3, (innerIndex) {
                                      final itemIndex = index * 3 + innerIndex;
                                      if (itemIndex <
                                              controller.selectedFilesWithType
                                                  .length &&
                                          controller
                                                  .selectedFilesWithType[
                                                      itemIndex]
                                                  .type ==
                                              DocumentType.shop_photos) {
                                        return SizedBox(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  32.0) /
                                              4, // Adjust the width as needed considering borders and margins
                                          child: Stack(
                                            children: [
                                              Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                      onTap: () {
                                                        print(
                                                            'licence clikedd....$innerIndex,$index');
                                                      },
                                                      child:
                                                          Icon(Icons.cancel))),
                                              Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors
                                                        .black, // Change the color of the border as needed
                                                    width:
                                                        1.0, // Adjust the width of the border as needed
                                                  ),
                                                ),
                                                child: Image.file(
                                                  controller
                                                      .selectedFilesWithType[
                                                          itemIndex]
                                                      .file,
                                                  fit: BoxFit.contain,
                                                  height: 100,
                                                ),
                                              ),
                                              InkWell(
                                              onTap: () {
                                                controller
                                                .selectedFilesWithType.removeAt(index);
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.black,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                  );
                                },
                              )),
                          Obx(() =>  GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemCount: controller.userDocumentsPhoto!
                                    .length, // Number of items in each row
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors
                                            .black, // Change the color of the border as needed
                                        width:
                                            1.0, // Adjust the width of the border as needed
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Image.network(
                                            '${ApiService.imageURL}shop_photos/${controller.userDocumentsPhoto[rowIndex]["shop_photos"]}',
                                            fit: BoxFit.contain,
                                            height: 100,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            print(
                                                'licence clikedd....${controller.userDocumentsPhoto[rowIndex]["id"]}');
                                            controller.deleteUploads(
                                                'photo', rowIndex, context);
                                          },
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: MaterialButton(
                      onPressed: () {
                        controller.uploadFiles(context);
                      },
                      color: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
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
