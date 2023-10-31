import 'package:bmi_calcur/presentation/log_meals/controllers/add_log_meal.controller.dart';
import 'package:get/get.dart';

class AddLogMealControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLogMealController>(
          () => AddLogMealController(),
    );
  }
}
