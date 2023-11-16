import 'dart:ffi';

import 'package:bmi_calcur/Util/util.dart';
import 'package:bmi_calcur/data/model/bmi_model.dart';
import 'package:bmi_calcur/presentation/component/textView.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/common/common.dart';
import '../navigation/routes.dart';
import 'controllers/log_meals.controller.dart';

class LogMealsScreen extends GetView<LogMealsController> {
  const LogMealsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(

          body: Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: Common.maxWidth
              ),
              child: Column(
                children: [
                  Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      controller.previousMonth();
                                    },
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM').format(controller.calenderDateTime
                                        .value), // 현재 월 표시
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward),
                                    onPressed: () {
                                      controller.nextMonth();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 20,
                                child: LayoutBuilder(
                                  builder: (context, calenderConstraints)  {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: calenderConstraints.maxWidth/7,
                                          child: Center(
                                            child: TextView(
                                              txt: controller.dayOfWeek[index],
                                              color: index==0? Colors.red : null,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: controller.dayOfWeek.length,
                                    );
                                  }
                                ),
                              ),
                              const SizedBox(height: 10),
                              Table(
                               // border: TableBorder.all(),
                                children: buildCalendar(controller.calenderDateTime.value),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Expanded(
                    child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight
                              ),
                              child: IntrinsicHeight(
                                child: Obx(
                                  () =>  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //일
                                      Container(
                                        width: double.infinity,
                                        height: 35,
                                        color: Common.lineColor,
                                        child: Row(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: TextView(
                                                left: 16,
                                                txt: '${controller.dateTime.value
                                                    .day} 일',
                                                size: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                                style: ButtonStyle(
                                                  overlayColor:
                                                  MaterialStateProperty.all
                                                    (Common.mainColor),
                                                ),
                                              onPressed: (){
                                              controller.saveDietList();
                                              },
                                              child: TextView(
                                                txt: '저장',
                                              ))
                                          ],
                                        ),
                                      ),
                                      //아침 점심 저녁
                                      dietBar(
                                          barColor: const Color(0xfff5f5f5),
                                          controller: controller
                                              .breakfastController,
                                          title: '아침',
                                          imagePath: 'tag_morning.png',
                                        index: 0
                                      ),
                                      dietBar(
                                          barColor: const Color(0xffebebeb),
                                          controller: controller.lunchController,
                                          title: '점심',
                                          imagePath: 'tag_afternoon.png',
                                          index: 1
                                      ),
                                      dietBar(
                                          barColor: const Color(0xfff5f5f5),
                                          controller: controller.dinnerController,
                                          title: '저녁',
                                          imagePath: 'tag_night.png',
                                          index: 2
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  List<TableRow> buildCalendar(dateTime) {
    List<TableRow> rows = [];
    int daysInMonth = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    int startingWeekday = DateTime(dateTime.year, dateTime.month, 1).weekday;
    int weeksInMonth = Util().calculateWeeksInMonth(dateTime);
    int dayCounter = 1;

    if(startingWeekday ==7){weeksInMonth -=1;}
    for (int i = 0; i < weeksInMonth; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < 7; j++) {
        if ( (i ==0 && j < startingWeekday && startingWeekday != 7) ||
            dayCounter > daysInMonth)
        {
          cells.add(Container(
            height: 55,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Common.lineColor, width: 2),
              ),
            ),
          )); // 빈 칸 추가
        } else {

          int currentDayCounter = dayCounter; // dayCounter를 복사하여 사용
          String dateTime = Util().getDate(DateTime(
            controller.calenderDateTime.value.year,
            controller.calenderDateTime.value.month,
            currentDayCounter, // 복사한 변수를 사용
          ));
          List<bool> isExist = [false,false,false];

          BmiModel bmiModel = controller.bmiCalulController.bmiModelList.value
              .firstWhere((element) => element.time == dateTime,
              orElse: ()=> BmiModel(bmi: 0, weight: 0, time: dateTime, diet: ['','',
                ''])
          );
          for(int i = 0; i < 3; i++){
            if(bmiModel.diet[i] != "") isExist[i] = true;
          }

          cells.add(
            GestureDetector(
              onTap: () {
                controller.selectedDate(currentDayCounter);
              },
              child: Container(
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Common.lineColor, width: 2),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 4, left: 4),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextView(
                          txt: '$currentDayCounter', // 복사한 변수를 사용
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                              child: isExist[2]? Image.asset('${Common
                                  .imagePath}tag_night.png',width: 30, fit:
                              BoxFit
                                  .fill,) : Container()),
                          const SizedBox(height: 2,),
                          Expanded(
                              child: isExist[1]? Image.asset('${Common
                                  .imagePath}tag_afternoon.png',width: 30, fit:
                              BoxFit
                                  .fill,): Container()),
                          const SizedBox(height: 2,),
                          Expanded(
                              child:  isExist[0]? Image.asset('${Common
                                  .imagePath}tag_morning.png',width: 30, fit:
                              BoxFit
                                  .fill,): Container()),
                          const SizedBox(height: 2,),
                          const SizedBox(height: 5,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          dayCounter++;
        }
      }
      rows.add(TableRow(children: cells));
    }
    return rows;
  }

  Widget dietBar({
    required var title,
    required Color barColor,
    required TextEditingController controller,
    required String imagePath,
    required int index
  }) {
    return Expanded(
      child: Container(
        color: barColor,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Image.asset(Common.imagePath + imagePath, width:
                    35, height: 40,),
                  ),
                  TextView(
                    top: 10,
                    bottom: 10,
                    txt: title,
                    size: 18,
                    fontWeight: FontWeight.bold,

                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IntrinsicWidth(
                    //stepWidth: 50,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 350
                      ),
                      child: TextField(
                        controller: controller,
                        maxLines: null,

                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '식단 입력',
                            suffixIcon: Image.asset('${Common
                                .imagePath}icon_edit'
                                '.png', width: 10, height: 10,),
                            suffixIconConstraints: BoxConstraints(
                                maxWidth: 20
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),

                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
