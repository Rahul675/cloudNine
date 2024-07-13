import 'package:cloudnine/Verify/verifyController.dart';
import 'package:cloudnine/routes.dart';
import 'package:cloudnine/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends GetView<VerifyController> {
  // late List<FocusNode> _focusNodes;
  // late FocusNode phonefocusNodes = FocusNode();
  // late FocusNode emailfocusNodes = FocusNode();
  final List<TextEditingController> _phoneControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  final List<TextEditingController> _emailControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final token = Get.arguments['token'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FadeInUp(
                duration: Duration(milliseconds: 1500),
                child: Text(
                  "Verify Details",
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
              Obx(
                () => controller.verifyPhone.value
                    ? Center(child: Text('Phone verified'))
                    : Container(
                        child: Column(
                          children: [
                            FadeInUp(
                              duration: Duration(milliseconds: 1700),
                              child: Text(
                                'Enter the 6-digit code sent to your phone',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            FadeIn(
                              duration: Duration(milliseconds: 500),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  6,
                                  (index) => SizedBox(
                                    width: 50.0,
                                    child: TextField(
                                      controller: _phoneControllers[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      autofocus: index == 0,
                                      // focusNode: phonefocusNodes,
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hoverColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        fillColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        iconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        prefixIconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        suffixIconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        focusColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        counterText: '',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      49, 39, 79, 1))),
                                      onPressed: () {
                                        // Validate the entered code and proceed
                                      },
                                      child: Text(
                                        'Resend',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30.0),
                                FadeInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      49, 39, 79, 1))),
                                      onPressed: () {
                                        // Validate the entered code and proceed
                                        final phoneOtp = _phoneControllers
                                            .map(
                                                (controller) => controller.text)
                                            .join();
                                        ApiService.emailAndPhoneVerify(
                                                token, phoneOtp, 'phone')
                                            .then((value) {
                                          if (value) {
                                            controller.verifyPhone.value = true;
                                            if (controller.verifyPhone ==
                                                    true &&
                                                controller.verifyEmail ==
                                                    true) {
                                              Get.offNamed(Routes.LOGIN);
                                            }
                                          }
                                        });

                                        // Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Verify',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              Obx(
                () => controller.verifyEmail.value
                    ? Center(child: Text('Email verified'))
                    : Container(
                        child: Column(
                          children: [
                            FadeInUp(
                              duration: Duration(milliseconds: 1700),
                              child: Text(
                                'Enter the 6-digit code sent to your email',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            FadeIn(
                              duration: Duration(milliseconds: 500),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  6,
                                  (index) => SizedBox(
                                    width: 50.0,
                                    child: TextField(
                                      controller: _emailControllers[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      autofocus: index == 0,
                                      // focusNode: emailfocusNodes,
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hoverColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        fillColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        iconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        prefixIconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        suffixIconColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        focusColor:
                                            Color.fromRGBO(49, 39, 79, 1),
                                        counterText: '',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      49, 39, 79, 1))),
                                      onPressed: () {
                                        // Validate the entered code and proceed
                                      },
                                      child: Text(
                                        'Resend',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 30.0),
                                FadeInUp(
                                  duration: Duration(milliseconds: 500),
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Color.fromRGBO(
                                                      49, 39, 79, 1))),
                                      onPressed: () {
                                        final emailOtp = _emailControllers
                                            .map(
                                                (controller) => controller.text)
                                            .join();
                                        // Validate the entered code and proceed
                                        ApiService.emailAndPhoneVerify(
                                                token, emailOtp, 'email')
                                            .then((value) {
                                          if (value) {
                                            controller.verifyEmail.value = true;
                                            if (controller.verifyPhone ==
                                                    true &&
                                                controller.verifyEmail ==
                                                    true) {
                                              Get.offNamed(Routes.LOGIN);
                                            }
                                          }
                                        });
                                        // Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Verify',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
