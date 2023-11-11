import 'dart:ffi';

import 'package:bmi_calcur/Util/util.dart';
import 'package:bmi_calcur/presentation/component/textView.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../data/common/common.dart';
import '../navigation/routes.dart';
import 'controllers/log_meals.controller.dart';

class LogMealsScreen extends GetView<LogMealsController> {
  const LogMealsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(

          children: [
            Container(
              color: Colors.red,
              height: 260,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.yellow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //일
                    Container(
                      width: double.infinity,
                      height: 32,
                      color: Common.lineColor,
                      child: TextView(
                        left: 16,
                        txt: '${controller.dateTime.value.day} 일',
                        size: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //아침
                    dietBar(
                        barColor: const Color(0xfff5f5f5),
                        controller: controller.breakfastController,
                        title: '아침'
                    ),
                    dietBar(
                        barColor: const Color(0xffebebeb),
                        controller: controller.breakfastController,
                        title: '점심'
                    ),
                    dietBar(
                        barColor: const Color(0xfff5f5f5),
                        controller: controller.breakfastController,
                        title: '저녁'
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )

        // floatingActionButton : FloatingActionButton(
        //   onPressed: () {
        //     Get.toNamed(Routes.ADD_LOG_MEALS,arguments: {
        //       'bmiModel' : controller.getDietList(Util().getDate(DateTime.now
        //         ()))
        //     });
        //   },
        //   backgroundColor: Colors.blue,
        //
        //   shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(45)
        //   ),
        //   child: const Icon(Icons.add,color: Colors.white,size: 45,weight: 23,),
        //
        // )
    );
  }

  Widget dietBar({required var title, required Color barColor, required
  TextEditingController controller
  }){
    return Expanded(
      child: Container(
        color: barColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                top: 10,
                bottom: 10,
                txt: title,
                size: 18,
                fontWeight: FontWeight.bold,
              ),
              TextField(
                controller:  controller,
                decoration:  InputDecoration(
                    suffix: Image.asset('${Common.imagePath}icon_edit.png'),

                    border: InputBorder.none
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
