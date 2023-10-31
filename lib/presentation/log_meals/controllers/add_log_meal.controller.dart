import 'package:bmi_calcur/Util/util.dart';
import 'package:bmi_calcur/data/repository/hive_repository.dart';
import 'package:bmi_calcur/presentation/bmi_calculator/controllers/bmi_calculator.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddLogMealController extends GetxController{
  RxList<String> dietList = <String>[].obs;
  late TextEditingController textEditingController;
  final bmiCalculContoller = Get.find<BmiCalculatorController>();
  final hiveRepository = HiveRepository();
  DateTime dateTime = DateTime.now();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    textEditingController = TextEditingController();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    //dietList.value = [];
    super.onClose();
    textEditingController.dispose();
  }

  void addDiet(String diet){
    if(diet.isEmpty) return;
    dietList.value.add(diet);
    textEditingController.text ="";
    update();
  }

  void deleteDiet(int index){
    dietList.value.removeAt(index);
  }

  void saveDietList() async{
    if(dietList.value.isNotEmpty){
      bmiCalculContoller.bmiModelList.value = await hiveRepository.saveDiet(Util()
          .getDate(dateTime), dietList.value);

    }
    Get.back();
  }
}