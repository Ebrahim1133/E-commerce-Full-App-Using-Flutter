import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/cart_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/theme.dart';
import '../text_utils.dart';


class CartTotal extends StatelessWidget {
  CartTotal({Key? key}) : super(key: key);

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextUtils(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  text: "Total",
                  color: Colors.grey,
                  underLine: TextDecoration.none,
                ),
                Text(
                  "\$${controller.total}",
                  style: TextStyle(
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    primary: Get.isDarkMode ? pinkClr : mainColor,
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.paymentScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.shopping_cart),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
