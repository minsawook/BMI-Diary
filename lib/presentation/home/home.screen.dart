import 'package:bmi_calcur/presentation/bmi_calculator/bmi_calculator.screen.dart';
import 'package:bmi_calcur/presentation/bmi_history/bmi_history.screen.dart';
import 'package:bmi_calcur/presentation/component/image_button.dart';
import 'package:bmi_calcur/presentation/component/textView.dart';
import 'package:bmi_calcur/presentation/log_meals/log_meals.screen.dart';
import 'package:bmi_calcur/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math'  as math;
import '../../data/common/common.dart';
import 'controllers/home.controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);


   final screen = [const BmiCalculatorScreen(),const BmiHistoryScreen(),
    const LogMealsScreen(),const SettingsScreen()];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Container(

            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 20,right: 10),
                  child: Row(
                    children: [
                      Obx(
                            () =>  SizedBox(
                              width: 25,height: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(45)),
                          child: controller.isLogin.value == false? Image
                                .asset('${Common.imagePath}icon_guest.png')
                                : Image.network(controller.userModel!.profileUrl),
                        ),
                            ),
                      ),
                      SizedBox(width: 15,),
                      TextView(txt: controller.isLogin.value == false? '게스트'
                          : controller.userModel!.email.split('@')[0]),
                      Spacer(),
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(Icons.close,weight: 100,size: 30,))
                    ],
                  ),
                ),
                Divider(thickness: 1.5,color: Common.lineColor,),
                SizedBox(height: 10,),
                settingBox(
                  '계정 연동',
                    (){
                      controller.signInWithGoogle();
                    }
                ),
                settingBox(
                    '백업',
                        (){
                      controller.saveBmiData();
                    }
                ),
                settingBox(
                    '불러오기',
                        (){
                      controller.loadBmiData();
                    }
                ),
                settingBox(
                    '언어',
                        (){
                    },
                    null,
                  10
                ),
                Divider(thickness: 1.5,color: Common.lineColor,),
                SizedBox(height: 10,),
                settingBox(
                    '이용약관',
                        (){
                    }
                ),
                settingBox(
                    '개인정보 정책',
                        (){
                    }
                ),
                settingBox(
                    '로그아웃',
                        (){
                      controller.signOut();
                    },
                  Color(0xff8c2525)
                ),
              ],
            ),
          ),
        ),

      ),
      body:  Obx(
        () => Column(
          children: [
            Container(
              height:  MediaQuery.of(context).padding.top,
              color: controller.index ==1?Common.mainColor : Colors.transparent,
            ),
            //앱바
             Container(
               height: 40,
               color: controller.index ==1?Common.mainColor : Colors.transparent,
               child: Padding(
                padding: const EdgeInsets.only(top: 10,left: 22,right: 22,bottom:
                10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     TextView(
                       txt: controller.title[controller.index.value],
                       fontWeight: FontWeight.bold,
                       size: 18,
                     ),
                    const Spacer(),
                    ImageButton(
                      width: 22,
                      height: 22,
                      imagePath: 'icon_menu.png',
                      click: (){
                        _scaffoldKey.currentState!.openEndDrawer();

                      },
                    )
                  ],
                ),
            ),
             ),

            //메인
            Expanded(
              child: PageView(

                controller: controller.controller,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  controller.index.value = value;
                },
                children: const [
                  BmiHistoryScreen(),
                  BmiCalculatorScreen(),
                  LogMealsScreen()
                ],
              ),
            ),



            //하단
            Divider(thickness: 2,color: Common.lineColor,),
             SizedBox(
              width: double.infinity,
              height: 54,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){

                          },
                          child: SizedBox(
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageButton(imagePath: 'icon_arrow.png',
                                  width: 15,height: 15,),
                                const SizedBox(width: 10,),
                                TextView(
                                  txt: 'graph'.tr,
                                  size: 17,
                                  fontWeight: FontWeight.bold,
                                )
                              ],
                            ),
                          ),
                        ),
               GestureDetector(
                     onTap: (){

                     },
                     child: SizedBox(
                       height: double.infinity,
                       child: Row(
                         children: [
                           TextView(
                             txt: 'diary'.tr,
                             size: 17,
                             fontWeight: FontWeight.bold,
                           ),
                           const SizedBox(width: 10,),
                           Transform.rotate(
                               angle: 180 * math.pi / 180,
                               child: ImageButton(imagePath: 'icon_arrow.png',
                                   width: 15,height: 15)),
                         ],
                       ),
                     ),
               )
                      ],
                    ),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller.controller,
                        count: 3,
                        effect:  ExpandingDotsEffect(
                          dotHeight: 11,
                          dotWidth: 11,
                          expansionFactor: 2.3,
                          dotColor: Common.lineColor,
                          activeDotColor: Common.mainColor,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )

    );
  }
}

Widget settingBox(String title, Function click,[Color? color, double
padding=40]){
  return GestureDetector(
    onTap: (){
      click.call();
    },
    child: Container(
      padding: EdgeInsets.only(left: 17,right: 17,bottom: padding),
      width: double.infinity,
      color: Colors.transparent,
      child: TextView(
        txt:  title,
        color: color,
        fontWeight: FontWeight.w600,
        size: 17,
        align: Alignment.centerLeft,
      ),
    ),
  );
}
