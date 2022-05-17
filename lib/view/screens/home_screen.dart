import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';

import '../../utils/theme.dart';
import '../widgets/home/card_items.dart';
import '../widgets/home/search_text_form.dart';
import '../widgets/text_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? darkGreyClr : mainColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextUtils(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      text: "Find Your",
                      color: Colors.white,
                      underLine: TextDecoration.none,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextUtils(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      text: "INSPIRATION",
                      color: Colors.white,
                      underLine: TextDecoration.none,
                    ),
                    const SizedBox(height: 20),
                    SearchFormText(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextUtils(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  text: "Categories",
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  underLine: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CardItems(),
          ],
        ),
      ),
    );
  }
}
