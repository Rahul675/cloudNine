import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadDocuments extends StatefulWidget {
  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  List<PlatformFile> _businessLicenseFiles = [];
  List<PlatformFile> _contactPersonIdFiles = [];
  List<PlatformFile> _businessPhotos = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                      "Upload Documents",
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
                          TextButton(
                            onPressed: () async {
                              List<PlatformFile> files =
                                  (await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: ['pdf', 'doc', 'docx'],
                              )) as List<PlatformFile>;
                              setState(() {
                                _businessLicenseFiles = files;
                              });
                            },
                            child: Text(
                              'Upload Business License',
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                            ),
                          ),
                          if (_businessLicenseFiles.isNotEmpty)
                            Text(
                                'Selected files: ${_businessLicenseFiles.length}'),
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
                          TextButton(
                            onPressed: () async {
                              List<PlatformFile> files =
                                  (await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.custom,
                                allowedExtensions: [
                                  'pdf',
                                  'doc',
                                  'docx',
                                  'jpg',
                                  'jpeg',
                                  'png'
                                ],
                              )) as List<PlatformFile>;
                              setState(() {
                                _contactPersonIdFiles = files;
                              });
                            },
                            child: Text(
                              'Upload Contact Person ID',
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                            ),
                          ),
                          if (_contactPersonIdFiles.isNotEmpty)
                            Text(
                                'Selected files: ${_contactPersonIdFiles.length}'),
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
                          TextButton(
                            onPressed: () async {
                              FilePickerResult? files =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                type: FileType.image,
                              );
                              setState(() {
                                _businessPhotos = files as List<PlatformFile>;
                              });
                            },
                            child: Text(
                              'Upload Business/Shop Photos',
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                            ),
                          ),
                          if (_businessPhotos.isNotEmpty)
                            Text('Selected files: ${_businessPhotos.length}'),
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
                        // Validate and submit the uploaded documents
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
