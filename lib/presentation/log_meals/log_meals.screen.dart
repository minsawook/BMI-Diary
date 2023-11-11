import 'package:bmi_calcur/Util/util.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../navigation/routes.dart';
import 'controllers/log_meals.controller.dart';

class LogMealsScreen extends GetView<LogMealsController> {
  const LogMealsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogMealsScreen'),
        centerTitle: true,
      ),
      body: GetBuilder<LogMealsController>(
        builder: (_) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.ADD_LOG_MEALS,arguments: {
                        'bmiModel' : controller.getDietList(_.dietList.value[index].time)
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Text(_.dietList.value[index].diet[0]),
                    ),
                  );
                },
                itemCount: _.dietList.value.length,
              ),
          );
        }
      ),

        floatingActionButton : FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_LOG_MEALS,arguments: {
              'bmiModel' : controller.getDietList(Util().getDate(DateTime.now
                ()))
            });
          },
          backgroundColor: Colors.blue,

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45)
          ),
          child: const Icon(Icons.add,color: Colors.white,size: 45,weight: 23,),

        )
    );
  }
}
