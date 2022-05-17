import 'package:get/instance_manager.dart';

import '../controllers/cart_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProductController());
    Get.lazyPut(() => CartController());
    Get.put(CategoryController());
  }
}
