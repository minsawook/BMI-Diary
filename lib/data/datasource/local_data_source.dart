import 'package:bmi_calcur/data/model/bmi_model.dart';
import 'package:hive/hive.dart';

class LocalDataSource{

  //단위 가져오기
  Future<List> getUnit() async {
    var box =  await Hive.openBox('unit');
    List<int> result = [];
    result.add(box.get('heightUnit',defaultValue: 0));
    result.add(box.get('weightUnit',defaultValue: 0));
    return result;
  }

  void setHeightUnit(int unit) async{
    var box =  await Hive.openBox('unit');
    box.put('heightUnit', unit);
  }

  void setWeightUnit(int unit) async{
    var box =  await Hive.openBox('unit');
    box.put('weightUnit', unit);
  }

  //bmi데이터 가져오기
  Future<List<BmiModel>> getCachedBmiModel() async {
    var postBox = await Hive.openBox<BmiModel>('bmiModelList');
    return postBox.values.toList();
  }
  //bmi모델 저장
  void saveBmiModel(double bmi, double weight, String date, List<String> diet)
  async {
    var postBox = await Hive.box<BmiModel>('bmiModelList');

    BmiModel bmiModel = BmiModel(bmi: bmi, weight: weight, time: date, diet: diet);

    // Check if an item with the same date already exists.
    int? existingIndex;
    for (int i = 0; i < postBox.length; i++) {
      if (postBox.getAt(i)!.time == date) {
        existingIndex = i;
        break;
      }
    }

    if (existingIndex != null) {
      // If an item with the same date exists, update it.
      var dietList = postBox.getAt(existingIndex)?.diet;
      bmiModel.diet = dietList!;
      postBox.putAt(existingIndex, bmiModel);
    } else {
      // Otherwise, add a new item.
      postBox.add(bmiModel);
    }
  }

  //bmi 기록 지우기
  void clearBmiModel() {
    var postBox =  Hive.box<BmiModel>('bmiModelList');
    postBox.clear();
  }

  //식단 저장
  Future<List<BmiModel>> saveDiet(String date, List<String> diet) async{
    var postBox = await Hive.openBox<BmiModel>('bmiModelList');

    int? existingIndex;
    for (int i = 0; i < postBox.length; i++) {
      if (postBox.getAt(i)!.time == date) {
        existingIndex = i;
        break;
      }
    }

    BmiModel? bmiModel = BmiModel(bmi: 0, weight: 0, time: date, diet: diet);
    if (existingIndex != null) {
      bmiModel = postBox.getAt(existingIndex);
      bmiModel?.diet = diet;
      // If an item with the same date exists, update it.
      postBox.putAt(existingIndex, bmiModel!);
    } else {
      // Otherwise, add a new item.
      postBox.add(bmiModel);
    }

    return postBox.values.toList();
  }

  // List<String> getDietList(List<BmiModel> bmiList){
  //   List<String> dietList = [];
  //
  //   for(var bmiModel in bmiList){
  //     if(bmiModel.diet.isNotEmpty) dietList.ad
  //   }
  //
  //
  //   return dietList;
  // }
  }
