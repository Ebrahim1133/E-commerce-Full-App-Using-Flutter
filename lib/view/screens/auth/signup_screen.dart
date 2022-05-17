import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/auth/check_widget.dart';
import '../../widgets/auth/container_under.dart';
import '../../widgets/text_utils.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final fromKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          elevation: 0,
        ),
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: "SIGN",
                              color: Get.isDarkMode ? pinkClr : mainColor,
                              underLine: TextDecoration.none,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: "UP",
                              color:
                              Get.isDarkMode ? Colors.white : Colors.black,
                              underLine: TextDecoration.none,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AuthTextFromField(
                          controller: nameController,
                          obscureText: false,
                          validator: (value) {
                            if (value.toString().length <= 2 ||
                                !RegExp(validationName).hasMatch(value)) {
                              return 'Enter valid name';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Get.isDarkMode
                              ? const Icon(
                            Icons.person,
                            color: pinkClr,
                            size: 30,
                          )
                              : Image.asset('assets/images/user.png'),
                          suffixIcon: const Text(""),
                          hintText: 'User Name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AuthTextFromField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (!RegExp(validationEmail).hasMatch(value)) {
                              return 'Invalid email';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Get.isDarkMode
                              ? const Icon(
                            Icons.email,
                            color: pinkClr,
                            size: 30,
                          )
                              : Image.asset('assets/images/email.png'),
                          suffixIcon: const Text(""),
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) {
                            return AuthTextFromField(
                              controller: passwordController,
                              obscureText:
                              controller.isVisibilty ? false : true,
                              validator: (value) {
                                if (value.toString().length < 6) {
                                  return 'Password should be longer or equal to 6 characters';
                                } else {
                                  return null;
                                }
                              },
                              prefixIcon: Get.isDarkMode
                                  ? const Icon(
                                Icons.lock,
                                color: pinkClr,
                                size: 30,
                              )
                                  : Image.asset('assets/images/lock.png'),
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.visibility();
                                },
                                icon: controller.isVisibilty
                                    ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                )
                                    : const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CheckWidget(),
                        const SizedBox(
                          height: 50,
                        ),
                        GetBuilder<AuthController>(
                          builder: (_) {
                            return AuthButton(
                              onPressed: () {
                                if (controller.isCheckBox == false) {
                                  Get.snackbar(
                                    "Check Box",
                                    "Please, Accept terms & conditions",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                } else if (fromKey.currentState!.validate()) {
                                  String name = nameController.text.trim();
                                  String email = emailController.text.trim();
                                  String password = passwordController.text;
                                  controller.signUpUsingFirebase(
                                    name: name,
                                    email: email,
                                    password: password,
                                  );

                                  controller.isCheckBox = true;
                                }
                              },
                              text: "SIGN UP",
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: 'Already have an Account? ',
                textType: "Log in",
                onPressed: () {
                  Get.offNamed(Routes.loginScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
