import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/model/bmi_model.dart';
import '../../../data/model/user_Model.dart';
import '../../../data/repository/firebase_repositoty.dart';
import '../../../data/repository/hive_repository.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late PageController controller;
  final index = 1.obs;

  UserModel? userModel;
  final firebaseRepository = FirebaseRepository();
  final hiveRepository = HiveRepository();
  Rx<bool> isLogin = false.obs;

  List<String> title = ['히스토리','Bmi 계산', '다이어리'];
  @override
  Future<void> onInit() async {
    super.onInit();
    controller = PageController(initialPage: index.value);

    isLogin.value = firebaseRepository.isLoggedIn();
    if(isLogin.value) {
      userModel =  await firebaseRepository.initUser();
      saveBmiData();
    }

  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
    super.onClose();
    controller.dispose;
  }

  void signInWithGoogle() async{
    UserCredential userCredential = await firebaseRepository
        .signInWithGoogle();
    if(userCredential.user != null){
      isLogin.value = firebaseRepository.isLoggedIn();
      userModel =  await firebaseRepository.initUser();
    }
  }

  void signOut()async{
    await firebaseRepository.signOut();
    isLogin.value = firebaseRepository.isLoggedIn();
    print(isLogin.value);
  }

  void saveBmiData() async{
    List<BmiModel> bmiList = await hiveRepository.getCachedBmiModel();
    firebaseRepository.saveBmiData(bmiList, userModel!.email);
  }

  void loadBmiData() async {
    List<BmiModel> bmiModelList =[];
    bmiModelList = await firebaseRepository.loadBmiData(userModel!.email);
    hiveRepository.backUpBmiModel(bmiModelList);
  }
  void changeIndex(int idx) => index.value = idx;
}
