import 'dart:ffi';

import 'package:bmi_calcur/presentation/bmi_calculator/controllers/bmi_calculator.controller.dart';
import 'package:bmi_calcur/presentation/bmi_history/controllers/bmi_history.controller.dart';
import 'package:get/get.dart';

import '../../../data/model/bmi_model.dart';

class LogMealsController extends GetxController {
  //TODO: Implement LogMealsController

  final bmiCalulController = Get.find<BmiCalculatorController>();
  RxList<BmiModel> dietList = <BmiModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    ever(bmiCalulController.bmiModelList, (callback) => initDietList());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initDietList(){
    dietList.value.clear();
    for(int i =0; i<bmiCalulController.bmiModelList.length; i++){
      if(bmiCalulController.bmiModelList.value[i].diet.isNotEmpty) {
        dietList.add(bmiCalulController.bmiModelList.value[i]);
      }
    }
    update();
  }

  BmiModel getDietList(String date){
    for(BmiModel diet in dietList.value){
      if(diet.time ==date){
        return diet;
      }
    }
    return BmiModel(bmi: 0, weight: 0, time: date, diet: []);
  }
}
