import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/home/homeController.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    
    // controller.requestPermissions();
    // final loginController = Get.find<LoginController>();
    //var login = loginController.userData.value.users_business_licences!;
    var user = Provider.of<MasterDataProvider>(context, listen: false);
    //user.userData();
    var loginAt = user.user?.login_at.obs ?? "".obs;
    var users_business_licences =
        user.user?.users_business_licences.obs ?? "".obs;
    var users_business_ids = user.user?.users_business_ids.obs ?? "".obs;
    var users_business_shop_photo =
        user.user?.users_business_shop_photo.obs ?? "".obs;
    print("LOGINAT_${user.user?.users_business_licences}");
    print("LOGINAT_${user.user?.users_business_ids}");
    print("LOGINAT_${user.user?.users_business_shop_photo}");
    // print(user.userData());

    Future.delayed(Duration(milliseconds: 300)).then((_) {
      if (user.user != null) {
        if (user.user!.users_business_licences!.isEmpty &&
            user.user!.users_business_ids!.isEmpty &&
            user.user!.users_business_shop_photo!.isEmpty) {
          controller.documents();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Company Details'),
                  value: 'company_details',
                ),
                PopupMenuItem(
                  child: Text('Business Details'),
                  value: 'business_details',
                ),
                PopupMenuItem(
                  child: Text('Business Documents'),
                  value: 'business_documents',
                ),
                PopupMenuItem(
                  child: Text('Logout'),
                  value: 'logout',
                ),
              ];
            },
            child: CircleAvatar(
              radius: 25,
              backgroundImage:
                  AssetImage('assets/profile.png'), // Replace with your image
            ),
            onSelected: (value) {
              // Handle menu item selection here
              switch (value) {
                case 'company_details':
                  // Do something
                  controller.companyDetails();
                  break;
                case 'business_details':
                  // Do something
                  controller.businessDetails();
                  break;
                case 'business_documents':
                  // Do something
                  controller.documents();
                  break;
                case 'logout':
                  controller.logout(context);
                  break;
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Obx(()=> Text(user.user?.email)),
           Column(
                  children: [
                    Text("Welcome", style: TextStyle(fontSize: 28),),
                    // Text("Login At: ${users_business_licences}"),
                    // Text("Login At: ${users_business_ids}"),
                    // Text("Login At: ${users_business_shop_photo}")
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
