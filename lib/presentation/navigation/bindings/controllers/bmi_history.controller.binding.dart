import 'package:get/get.dart';

import '../../../../presentation/bmi_history/controllers/bmi_history.controller.dart';

class BmiHistoryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BmiHistoryController>(
      () => BmiHistoryController(),
    );
  }
}
