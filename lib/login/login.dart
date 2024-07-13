import 'package:cloudnine/DataProvider/master.dart';
import 'package:cloudnine/login/register_as_business.dart';
import 'package:cloudnine/login/loginController.dart';
import 'package:cloudnine/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: MediaQuery.of(context).size.height / 2,
                    width: width,
                    child: FadeInUp(
                      duration: Duration(seconds: 1),
                      child: Image.asset(
                        'assets/cloud9logo.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/cloud9logo.jpeg'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
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
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                ),
                              ),
                            ),
                            child: TextField(
                              controller: controller.usernameController,
                              onChanged: controller.setUsername,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: controller.passwordController,
                              onChanged: controller.setPassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeInUp(
                    duration: Duration(milliseconds: 1700),
                    child: Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color.fromRGBO(196, 135, 198, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: () {
                        if (controller.usernameController.text.isNotEmpty &&
                            controller.passwordController.text.isNotEmpty) {
                          // Get.toNamed(Routes.HOME);
                          controller.login().then((value) => Provider.of<MasterDataProvider>(context, listen: false).userData());
                        } else {
                          Get.snackbar(
                            'Empty Fields',
                            'Please enter valid username and password',
                            backgroundColor:
                                Color.fromRGBO(49, 39, 79, 1).withOpacity(0.9),
                            colorText: Colors.white,
                          );
                        }
                      },
                      color: Color.fromRGBO(49, 39, 79, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "User",
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.registerAsBusiness);
                            },
                            child: Text(
                              "Business",
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, .6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
