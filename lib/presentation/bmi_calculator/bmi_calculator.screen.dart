import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:bmi_calcur/Util/enum.dart';
import 'package:bmi_calcur/Util/util.dart';
import 'package:bmi_calcur/presentation/component/textView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

import 'package:get/get.dart';

import '../../data/common/common.dart';
import 'controllers/bmi_calculator.controller.dart';

class BmiCalculatorScreen extends GetView<BmiCalculatorController> {
  const BmiCalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child:  Center(
            child: LayoutBuilder(
                builder: (context, size) {
                  return Obx(
                    () => Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: size.maxHeight,

                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //상단
                                    SizedBox(
                                      width: double.infinity,
                                      height: 230,
                                      //color: Colors.red.withOpacity(0.2),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomPaint(
                                            size: Size(MediaQuery.of(context)
                                                .size.width,
                                                230),
                                            painter: halfCurcle(),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            child: Center(
                                              child: Image.asset('${Common
                                                  .imagePath}body_${controller
                                                  .bmiLevel.value+1}.png',
                                                height: 135,),
                                            ),
                                          ),

                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 5,),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff35CBEB),
                                                  borderRadius: BorderRadius.circular(45)
                                                ),
                                                child: TextView(
                                                  left: 8,
                                                  right: 8,
                                                  txt: controller
                                                      .bmiLevelString[controller
                                                      .bmiLevel.value],
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(height: 1,),
                                              TextView(
                                                left: 8,
                                                right: 8,
                                                txt: controller.bmi.value.toStringAsFixed(2),
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                size: 22,
                                              ),
                                              const SizedBox(height: 3,),
                                               Expanded(
                                                child: AnimatedRadialGauge(
                                                    duration: const Duration(milliseconds: 1),
                                                    curve: Curves.easeIn,

                                                   // radius: 200,
                                                    initialValue: controller.bmi.value,
                                                    value: controller.bmi.value,

                                                    axis: const GaugeAxis(
                                                      /// Provide the [min] and [max] value for the [value] argument.
                                                        min: 14,
                                                        max: 40,
                                                        degrees: 180,

                                                        /// Set the background color and axis thickness.
                                                        style: GaugeAxisStyle(
                                                          blendColors: true,
                                                          thickness: 20,
                                                          background: Colors.transparent,
                                                          segmentSpacing: 4,
                                                          cornerRadius: Radius.circular(90)
                                                        ),

                                                        /// Define the pointer that will indicate the progress (optional).
                                                        pointer: GaugePointer.triangle(
                                                          position: GaugePointerPosition.surface
                                                            (offset: Offset(0, 10)),
                                                          border: GaugePointerBorder(color: Colors
                                                              .white, width: 2),
                                                          width:15,
                                                          height: 15,
                                                          color: Colors.black,
                                                          borderRadius: 1.3,
                                                          shadow: Shadow(
                                                            color: Colors.black,
                                                            offset:Offset(24,3),
                                                            blurRadius: 45
                                                          )
                                                        ),
                                                        progressBar: GaugeProgressBar.rounded(
                                                          color: Colors.transparent,
                                                          placement: GaugeProgressPlacement.over
                                                        ),

                                                        segments: [
                                                          GaugeSegment(
                                                            from: 14,
                                                            to: 18.5,
                                                            cornerRadius: Radius.circular(0),
                                                            gradient: GaugeAxisGradient(colors: [
                                                              Color(0xff35CBEB),
                                                              Color(0xff48EBEA),
                                                              Color(0xff2BF8AF)
                                                            ],
                                                              colorStops: [0.4,0.7,1]
                                                            ),
                                                          ),
                                                          GaugeSegment(
                                                            from: 18.5,
                                                            to: 24.9,
                                                            gradient: GaugeAxisGradient(
                                                              colors: [
                                                                Color(0xff30FB8E),
                                                                Color(0xff67FF59),
                                                                Color(0xff98FF56)
                                                              ],
                                                              colorStops: [
                                                                0.4,0.7,1
                                                              ]
                                                            ),
                                                            cornerRadius: Radius.zero,
                                                          ),
                                                          GaugeSegment(
                                                            from: 25,
                                                            to: 29.9,
                                                            gradient: GaugeAxisGradient(colors: [
                                                              Color(0xffB3FF5C),
                                                              Color(0xffFFF662),
                                                              Color(0xffFFDB52)
                                                            ],
                                                                colorStops: [0.01,0.5,1]
                                                            ),
                                                            cornerRadius: Radius.zero,
                                                          ),
                                                          GaugeSegment(
                                                            from: 30,
                                                            to: 40,

                                                            gradient: GaugeAxisGradient(colors: [
                                                              Color(0xffFDC845),
                                                              Color(0xffE56F34),
                                                              Color(0xffE14B3D)
                                                            ],
                                                                colorStops: [0.2,0.6,1]
                                                            ),
                                                            cornerRadius: Radius.zero,
                                                          ),
                                                        ])
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),

                                    //하단
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 400
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextView(
                                                      txt: '성별',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    toggle(value: Sex.values.indexOf(controller.sex.value),
                                                      click: (int i){
                                                        controller.sex.value = Sex.values[i];
                                                      },
                                                      title: ['남성','여성']
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        showCupertinoDialog(
                                                          context: context,
                                                          barrierDismissible: true,
                                                          builder: (context) {
                                                            return Align(
                                                              alignment: Alignment.bottomCenter,
                                                              child: Container(
                                                                width: double.infinity,
                                                                height: MediaQuery.of(context).size
                                                                    .height*0.3,
                                                                color: Colors.white,
                                                                child: CupertinoDatePicker(
                                                                  maximumDate: DateTime.now(),
                                                                  mode: CupertinoDatePickerMode.date,
                                                                  use24hFormat: true,
                                                                  initialDateTime: controller.dateTime.value,
                                                                  onDateTimeChanged: (time) {
                                                                    controller.dateTime.value = time;
                                                                  },),
                                                              ),
                                                            );
                                                          },).then((value) {
                                                          // controller.changeBmiModel();
                                                        });
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          TextView(txt: '날짜',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          const SizedBox(height: 10,),
                                                          Container(
                                                            height: 45,
                                                            decoration: BoxDecoration(
                                                              color: Common.lineColor,
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            child: Center(
                                                               child: TextView(
                                                                 txt: Util().getDate(controller.dateTime.value) ,
                                                               )
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                    ))
                                              ],
                                            ),
                                            const SizedBox(height: 12,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: inputBox('신장',
                                                    controller.heightController,
                                                      0, context)
                                                ),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                    child: toggle(value: HeightUnit.values.indexOf
                                                      (controller.heightUnits.value),
                                                        click: (int i){
                                                          controller.heightUnits.value = HeightUnit.values[i];
                                                        },
                                                        title: ['cm','ft-in']
                                                    ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: inputBox('체중', controller
                                                        .weightController,
                                                       1, context)
                                                ),
                                                const SizedBox(width: 10,),
                                                Expanded(
                                                  child: toggle(value: WeightUnit.values.indexOf
                                                    (controller.weightUnits.value),
                                                      click: (int i){
                                                        controller.weightUnits.value = WeightUnit.values[i];
                                                      },
                                                      title: ['kg','lb']
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                            GestureDetector(
                                              onTap: (){
                                                controller.calculateBMI();
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: Common.mainColor,
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: TextView(
                                                    txt: '계산하기',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ),
                          ),
                        ),
                       // SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)

                      ],
                    ),
                  );
                }
              ),
          ),
        ),
    );
  }

  Widget inputBox(String title, TextEditingController textController, int
  index, BuildContext context ){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
          txt: title,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 10,),
        Container(
          height: 45,
          decoration: BoxDecoration(
              color: Common.lineColor,
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
            maxLength: 4,
            key: controller.globalKey[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: textController,
            cursorColor: Colors.black,
            onTap: (){
              // Future.delayed(Duration(milliseconds: 200)).then((value) {
              //   controller.scrollToField(index);
              // });

              // controller.scrollToField(focusNode);
            },
            decoration: const InputDecoration(
                counterText:'',
                border: InputBorder.none
            ),
          ),
        )
      ],
    );
  }
}



Widget toggle({dynamic value, required Function(int i) click, required List<String>
  title}){
  return AnimatedToggleSwitch<int>.size(
    current: value,//Sex.values.indexOf(controller.sex.value),
    style: ToggleStyle(
      backgroundColor: Common.lineColor,
      indicatorColor: Common.seletToggleColor,
      borderColor: Colors.transparent,
      borderRadius: BorderRadius.circular(15),
      indicatorBorderRadius: BorderRadius.circular(15),
    ),
    values: const [0, 1],
    iconOpacity: 1.0,
    selectedIconScale: 1.0,
    indicatorSize: const Size.fromWidth(100),
    iconAnimationType: AnimationType.onHover,
    styleAnimationType: AnimationType.onHover,
    spacing: 2.0,
    customSeparatorBuilder: (context, local, global) {
      final opacity =
      ((global.position - local.position).abs() - 0.5)
          .clamp(0.0, 1.0);
      return VerticalDivider(
          indent: 10.0,
          endIndent: 10.0,
          color: Colors.white38.withOpacity(opacity));
    },
    customIconBuilder: (context, local, global) {
      final text = title[local.index];
      return Center(
          child: Text(text,
              style: TextStyle(
                  color: Color.lerp(Colors.black, Colors.white,
                      local.animationValue))));
    },
    borderWidth: 0.0,
    onChanged: (i) {
      value =
      click.call(i);
    }
  );
}

class halfCurcle extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Common.mainColor;
    canvas.drawCircle(Offset(size.width*0.5, 0), size.height, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }

}