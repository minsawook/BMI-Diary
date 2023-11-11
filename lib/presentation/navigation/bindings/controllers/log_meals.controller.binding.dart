import 'package:get/get.dart';

import '../../../../presentation/log_meals/controllers/log_meals.controller.dart';

class LogMealsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogMealsController>(
      () => LogMealsController(),
    );
  }
}
