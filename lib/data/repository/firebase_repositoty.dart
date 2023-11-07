import 'package:bmi_calcur/data/datasource/firebase_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/bmi_model.dart';
import '../model/user_Model.dart';

class FirebaseRepository {
  final firebaseDataSource = FireBaseDatasource();

  Future<UserModel> initUser() async{
    UserModel userModel = await firebaseDataSource.initUser();
    return userModel;
  }

  Future<UserCredential> signInWithGoogle() async {
    UserCredential userCredential = await firebaseDataSource.signInWithGoogle();
    return userCredential;
    // if(userCredential.user != null){
    //   UserModel userModel =  await initUser();
    // }
  }

   Future<void> signOut() async{
     await firebaseDataSource.signOut();
  }

  bool isLoggedIn(){
    return firebaseDataSource.isLoggedIn();
  }

  void saveBmiData(List<BmiModel> bmiList, String email){
    firebaseDataSource.saveBmiData(bmiList, email);
  }

  Future<List<BmiModel>> loadBmiData( String email) async {
    return firebaseDataSource.loadBmiData(email);
  }
}