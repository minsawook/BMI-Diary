import 'package:get/get.dart';

import '../../../../presentation/bmi_calculator/controllers/bmi_calculator.controller.dart';

class BmiCalculatorControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BmiCalculatorController>(
      () => BmiCalculatorController(),
    );
  }
}
