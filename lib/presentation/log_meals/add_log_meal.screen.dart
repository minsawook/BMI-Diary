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
          return Column(
              children: [
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

          );
        }
      ),
    );
  }
}