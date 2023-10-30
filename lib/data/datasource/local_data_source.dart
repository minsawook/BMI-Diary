import 'package:bmi_calcur/data/model/bmi_model.dart';
import 'package:hive/hive.dart';

class LocalDataSource{

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

  Future<List<BmiModel>> getCachedBmiModel() async {
    var postBox = await Hive.openBox<BmiModel>('bmiModelList');
    return postBox.values.toList();
  }

  void saveBmiModel(double bmi, double weight, String date, List<dynamic> diet) async {
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
      postBox.putAt(existingIndex, bmiModel);
    } else {
      // Otherwise, add a new item.
      postBox.add(bmiModel);
    }
  }
  void clearBmiModel() {
    var postBox =  Hive.box<BmiModel>('bmiModelList');
    postBox.clear();
  }
  }
