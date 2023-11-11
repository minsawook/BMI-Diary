import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/settings.controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SettingsScreen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Obx(
            () =>  SizedBox(
              width: 100,height: 100,
              child: controller.isLogin.value == false? Icon(Icons
                  .account_circle_outlined)
              : Image.network(controller.userModel!.profileUrl),
            ),
          ),
          FilledButton(onPressed: (){
            controller.signInWithGoogle();
          }, child: Text("로그인")),
          FilledButton(onPressed: (){
            controller.signOut();
          }, child: Text("로그아웃")),
        ],
      )
    );
  }
}
