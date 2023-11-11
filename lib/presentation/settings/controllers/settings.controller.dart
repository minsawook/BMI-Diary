import 'package:bmi_calcur/data/model/bmi_model.dart';
import 'package:bmi_calcur/data/model/user_Model.dart';
import 'package:bmi_calcur/data/repository/firebase_repositoty.dart';
import 'package:bmi_calcur/data/repository/hive_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  UserModel? userModel;
  final firebaseRepository = FirebaseRepository();
  final hiveRepository = HiveRepository();
  Rx<bool> isLogin = false.obs;
  @override
  void onInit() async{
    super.onInit();
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
  }

  void signInWithGoogle() async{
    UserCredential userCredential = await firebaseRepository
        .signInWithGoogle();
    if(userCredential.user != null){
      isLogin.value = firebaseRepository.isLoggedIn();
      userModel =  await firebaseRepository.initUser();

      saveBmiData();
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
}
