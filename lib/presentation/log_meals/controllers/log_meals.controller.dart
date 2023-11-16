import 'dart:ffi';

import 'package:bmi_calcur/presentation/bmi_calculator/controllers/bmi_calculator.controller.dart';
import 'package:bmi_calcur/presentation/bmi_history/controllers/bmi_history.controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Util/util.dart';
import '../../../data/model/bmi_model.dart';
import '../../../data/repository/hive_repository.dart';

class LogMealsController extends GetxController {
  //TODO: Implement LogMealsController

  final bmiCalulController = Get.find<BmiCalculatorController>();
  final hiveRepository = HiveRepository();

  RxList<BmiModel> dietList = <BmiModel>[].obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  late TextEditingController breakfastController;
  late TextEditingController lunchController;
  late TextEditingController dinnerController;

  Rx<DateTime> calenderDateTime = DateTime.now().obs;
  late RxInt daysInMonth;
  late RxInt startingWeekday;
  late RxInt weeksInMonth;
  List<String> dayOfWeek = ['일','월','화','수','목','금','토','일'];
  Rx<BmiModel> bmiModel = BmiModel(bmi: 0, weight: 0, time: '', diet: ['','',''])
      .obs;

  @override
  void onInit() {
    super.onInit();
    breakfastController = TextEditingController()..text = "";
    lunchController = TextEditingController()..text = "";
    dinnerController = TextEditingController()..text = "";

    ever(bmiCalulController.bmiModelList, (callback) => initDietList());

    changeCalender();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    breakfastController.dispose();
    lunchController.dispose();
    dinnerController.dispose();
  }

  void initDietList(){
    dietList.value.clear();
    for(int i =0; i<bmiCalulController.bmiModelList.length; i++){
      if(bmiCalulController.bmiModelList.value[i].diet.isNotEmpty) {
        dietList.add(bmiCalulController.bmiModelList.value[i]);
      }
    }
    setControllerText();
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

  void previousMonth() {
    calenderDateTime.value = DateTime(calenderDateTime.value.year, calenderDateTime.value .month - 1,);
    changeCalender();
  }

  void nextMonth() {
    calenderDateTime.value  = DateTime(calenderDateTime.value.year, calenderDateTime.value .month + 1,);
    changeCalender();
  }

  void changeCalender(){
    daysInMonth = DateTime(calenderDateTime.value.year, calenderDateTime.value.month + 1, 0)
        .day.obs;
    startingWeekday = DateTime(calenderDateTime.value.year, calenderDateTime.value.month, 1).weekday.obs;
    weeksInMonth = Util().calculateWeeksInMonth(calenderDateTime.value).obs;


  }

  void selectedDate(int count){
      dateTime.value = DateTime(
        calenderDateTime.value.year,
        calenderDateTime.value.month,
        count, // 복사한 변수를 사용
    );
      setControllerText();
  }

  void saveDietList() async{
    List<String> diet = [];
    diet.add(breakfastController.text);
    diet.add(lunchController.text);
    diet.add(dinnerController.text);

    bmiCalulController.bmiModelList.value = await hiveRepository.saveDiet
      (bmiModel.value.time, diet);
  }

  void setControllerText(){
    bmiModel.value = bmiCalulController.bmiModelList.value.firstWhere((element) =>
    element.time == Util().getDate(dateTime.value),
        orElse: ()=> BmiModel(bmi: 0, weight: 0, time: Util().getDate
          (dateTime.value), diet: ['','','']));
    breakfastController.text = bmiModel.value.diet[0];
    lunchController.text = bmiModel.value.diet[1];
    dinnerController.text = bmiModel.value.diet[2];
  }
}
