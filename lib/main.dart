import 'package:bmi_calcur/data/model/bmi_model.dart';
import 'package:bmi_calcur/presentation/bmi_calculator/controllers/bmi_calculator.controller.dart';
import 'package:bmi_calcur/presentation/bmi_history/controllers/bmi_history.controller.dart';
import 'package:bmi_calcur/presentation/log_meals/controllers/log_meals.controller.dart';
import 'package:bmi_calcur/presentation/navigation/navigation.dart';
import 'package:bmi_calcur/presentation/navigation/routes.dart';
import 'package:bmi_calcur/presentation/settings/controllers/settings.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'languages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  Hive.registerAdapter(BmiModelAdapter());
  await Hive.openBox<BmiModel>('bmiModelList');
  await Hive.openBox('unit');
  controllerInit();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(Main(initialRoute));
}

  controllerInit(){
    Get.put(BmiCalculatorController());
    Get.put(BmiHistoryController());
    Get.put(LogMealsController());
    Get.put(SettingsController());
  }
class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(), // 언어 정보 가져옴
      locale: Get.deviceLocale, //디바이스의 언어를 가져옴
      fallbackLocale: const Locale('es','US'), //현재 언어를 지원 안할 시 기본 언어
      initialRoute: initialRoute,
      getPages: Nav.routes,
    );
  }
}
