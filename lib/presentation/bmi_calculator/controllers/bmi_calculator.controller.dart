import 'dart:async';

import 'package:bmi_calcur/data/repository/hive_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Util/enum.dart';
import '../../../Util/util.dart';
import '../../../data/model/bmi_model.dart';

class BmiCalculatorController extends GetxController {
  //TODO: Implement BmiCalculatorController

  Rx<HeightUnit> heightUnits = HeightUnit.cm.obs;
  Rx<WeightUnit> weightUnits = WeightUnit.kg.obs;
  Rx<Sex> sex = Sex.male.obs;
  double heightCm = 0;
  double weightKg = 0;
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  RxDouble bmi =0.00.obs;
  double maxbmi = 0.0;
  final hiveRepository = HiveRepository();
  Rx<DateTime> dateTime = DateTime.now().obs;
  RxList<BmiModel> bmiModelList = <BmiModel>[].obs;

  ScrollController scrollController = ScrollController();
  List<GlobalKey> globalKey = [GlobalKey(),GlobalKey()];
  late Timer _timer;

  RxInt bmiLevel = 0.obs;
  List<String> bmiLevelString = ['저체중', '정상','과체중','위험체중','중도 비만','고도비만'];


  @override
  void onInit() async{
    super.onInit();
    var unitList = await hiveRepository.getUnit();
    heightUnits.value = HeightUnit.values[unitList[0]];
    weightUnits.value = WeightUnit.values[unitList[1]];
  }


  @override
  void onReady() async{
    bmiModelList.value = await hiveRepository.getCachedBmiModel();
    super.onReady();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    heightController.dispose();
    weightController.dispose();
    scrollController.dispose();
  }
  @override
  void onClose() {
    super.onClose();
  }

  Future saveBmi() {
    // TODO: implement saveBmi
    throw UnimplementedError();
  }

  void unitChange() {
    // TODO: implement unitChange
     heightCm = double.parse(heightController.text);
     weightKg = double.parse(weightController.text);
    if(heightUnits.value == HeightUnit.ftIn){
      heightCm = heightCm*30.48;
    }
    if(weightUnits.value == WeightUnit.lb){
      weightKg = weightKg/2.205;
    }
  }

  void bmiCalculator(double height, double weight){
    maxbmi = weight/(height * height);
  }

  void calculateBMI()async{
    //hiveRepository.clearBmiModel();
     FocusScope.of(Get.context!).unfocus();
     Future.delayed(const Duration(milliseconds: 1)).then((value) async {
       unitChange();
       bmiCalculator(heightCm/100, weightKg);

       var tick = maxbmi - bmi.value;
       print(tick);
       _timer = Timer.periodic(Duration(milliseconds: 1),
               (timer) {
         if (bmi.value < maxbmi && (bmi.value - maxbmi).abs() >0.1) {
           bmi.value += 0.03;
           bmiLevel.value = bmiLevelCheck(bmi.value);
         }
         else if(bmi.value > maxbmi && (bmi.value - maxbmi).abs() >0.1){
           bmi.value -= 0.03;
           bmiLevel.value = bmiLevelCheck(bmi.value);
         }
         else {
           _timer.cancel(); // 타이머를 중지합니다.
         }
       });


       hiveRepository.saveBmiModel(bmi.value, weightKg, Util().getDate(dateTime
           .value), []);
       bmiModelList.value = await hiveRepository.getCachedBmiModel();

     });


  }

  void heightUnitChange(HeightUnit unit){
    heightUnits.value = unit;
    hiveRepository.setHeightUnit(HeightUnit.values.indexOf(heightUnits.value));
  }

  void weightUnitChange(WeightUnit unit){
    weightUnits.value = unit;
    hiveRepository.setHeightUnit(WeightUnit.values.indexOf(weightUnits.value));
  }

  // void scrollToField(int i) {
  //   final context = globalKey[i].currentContext;
  //   if (context != null) {
  //     // Find the render object associated with the context
  //     final RenderBox renderBox = context.findRenderObject() as RenderBox;
  //     // Get the position of the render object
  //     final position = renderBox.localToGlobal(Offset.zero);
  //     // Scroll to the position of the render object
  //     scrollController.animateTo(
  //       position.dy,
  //       duration: const Duration(milliseconds: 1000),
  //       curve: Curves.ease,
  //     );
  //   }
  // }

  int bmiLevelCheck(double bmi){
    if(bmi <18.5){
      return 0;
    }
    else if(bmi <25){
      return 1;
    }
    else if(bmi <30){
      return 2;
    }
    else if(bmi <35){
      return 3;
    }
    else if(bmi <40){
      return 4;
    }
    else {
      return 5;
    }
  }
}


