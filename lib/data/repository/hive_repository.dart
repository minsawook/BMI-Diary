import 'package:bmi_calcur/data/datasource/local_data_source.dart';

import '../model/bmi_model.dart';
import 'firebase_repositoty.dart';

class HiveRepository {
  LocalDataSource localDataSource = LocalDataSource();

  Future<List<BmiModel>> getCachedBmiModel() async {
    var result = await localDataSource.getCachedBmiModel();
    return result;
  }

  void saveBmiModel(double bmi, double weight, String date, List<String> diet)
  async{
    var postBox =  localDataSource.saveBmiModel(bmi, weight, date, diet);
  }

  void setHeightUnit(int unit){
    localDataSource.setHeightUnit(unit);
  }

  void setWeightUnit(int unit){
    localDataSource.setWeightUnit(unit);
  }

  Future<List> getUnit(){
    return localDataSource.getUnit();
  }
  void clearBmiModel(){
    localDataSource.clearBmiModel();
  }

  Future<List<BmiModel>> saveDiet(String date, List<String> diet) async{
    return await localDataSource.saveDiet(date, diet);
  }
}