import 'package:bmi_calcur/data/model/user_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/bmi_model.dart';

class FireBaseDatasource {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> initUser() async{
    CollectionReference user =  firestore.collection('users');
    final checkUser = await user.doc(authentication.currentUser!.email).get();

    if(checkUser.data() == null){
      await user.doc(authentication.currentUser!.email).set({
        "uid" : authentication.currentUser!.uid,
        "name" : authentication.currentUser!.email,
        "email" : authentication.currentUser!.email,
        "profileUrl" : authentication.currentUser!.photoURL,
      });
    }
    UserModel userModel = UserModel(
        uid: authentication.currentUser!.uid,
        name: authentication.currentUser!.email.toString(),
        email: authentication.currentUser!.email.toString(),
        profileUrl: authentication.currentUser!.photoURL.toString());

    return userModel;
  }

  bool isLoggedIn() {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final UserCredential authResult =  await FirebaseAuth.instance
        .signInWithCredential(credential);

    return authResult;
  }


   Future<void> signOut() async{
    FirebaseAuth authentication = FirebaseAuth.instance;
    await authentication.signOut();
  }

  void saveBmiData(List<BmiModel> bmiList, String email){
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var bmiCollection = firestore.collection('users').
    doc(email).
    collection('bmi');
    
    for(var bmiData in bmiList){
      var bmiJson = bmiData.toJson();
      bmiCollection.doc(bmiJson['time']).set(bmiJson);
    }
  }

  Future<List<BmiModel>> loadBmiData(String email) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var bmiDocs = await firestore.collection('users').doc(email).collection
      ('bmi').get();

    List<BmiModel> bmiModelList = [];
    if(bmiDocs.docs.isNotEmpty){
      for(QueryDocumentSnapshot  doc in bmiDocs.docs){
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bmiModelList.add(BmiModel.fromJson(data));
      }
    }
    return bmiModelList;
  }
}