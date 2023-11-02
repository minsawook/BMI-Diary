import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'controllers/add_log_meal.controller.dart';

class AddLogMealScreen extends GetView<AddLogMealController>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: GetBuilder<AddLogMealController>(
        builder: (_) {
          return Obx(
            () =>  Column(
                children: [

                  TextButton(
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height: 300,
                                color: Colors.white,
                                child: CupertinoDatePicker(
                                  maximumDate: DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  initialDateTime: DateTime.parse(controller
                                      .bmiModel.value.time),
                                  onDateTimeChanged: (time) {
                                    controller.setDateTime(time);
                                },),
                              ),
                            );
                          },).then((value) {
                            controller.changeBmiModel();
                        });
                      },
                      child: Text(controller.bmiModel.value.time)),


                  ElevatedButton(onPressed: (){
                    controller.saveDietList();
                  }, child: Text('save')),
                  Expanded(child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Text(_.dietList.value[index]);
                    },
                    itemCount: _.dietList.value.length,
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.textEditingController,
                        ),
                      ),
                      ElevatedButton(onPressed: (){
                        controller.addDiet(controller.textEditingController.text);
                      }, child: Text('add'))
                    ],
                  )
                ],

            ),
          );
        }
      ),
    );
  }
}