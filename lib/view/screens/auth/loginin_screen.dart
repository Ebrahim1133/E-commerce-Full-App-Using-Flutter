import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/my_string.dart';
import '../../../utils/theme.dart';
import '../../widgets/auth/auth_button.dart';
import '../../widgets/auth/auth_text_from_field.dart';
import '../../widgets/auth/container_under.dart';
import '../../widgets/text_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final fromKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Get.isDarkMode ? darkGreyClr : Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 40),
                  child: Form(
                    key: fromKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: "LOG",
                              color: Get.isDarkMode ? pinkClr : mainColor,
                              underLine: TextDecoration.none,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            TextUtils(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              text: "IN",
                              color:
                              Get.isDarkMode ? Colors.white : Colors.black,
                              underLine: TextDecoration.none,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(Routes.forgotPasswordScreen);
                            },
                            child: TextUtils(
                              text: 'Forgot Password?',
                              fontSize: 14,
                              color:
                              Get.isDarkMode ? Colors.white : Colors.black,
                              underLine: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GetBuilder<AuthController>(builder: (_) {
                          return AuthButton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
                                String email = emailController.text.trim();
                                String password = passwordController.text;

                                controller.logInUsingFirebase(
                                    email: email, password: password);
                              }
                            },
                            text: "LOG IN",
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        TextUtils(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          text: "OR",
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          underLine: TextDecoration.none,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //   onTap: () {
                            //     controller.faceBookSignUpApp();
                            //   },
                            //   child: Image.asset(
                            //     "assets/images/facebook.png",
                            //   ),
                            // ),

                            GetBuilder<AuthController>(builder: (_) {
                              return InkWell(
                                onTap: () {
                                  controller.googleSinUpApp();
                                },
                                child: Image.asset(
                                  "assets/images/google.png",
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerUnder(
                text: "Don't have an Account? ",
                textType: "Sign up",
                onPressed: () {
                  Get.offNamed(Routes.signUpScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
