import 'package:bmi_calcur/presentation/log_meals/add_log_meal.screen.dart';
import 'package:bmi_calcur/presentation/navigation/bindings/controllers/add_logmeal.controller.binding.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/bmi_calculator.controller.binding.dart';
import 'bindings/controllers/bmi_history.controller.binding.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'bindings/controllers/home.controller.binding.dart';
import 'bindings/controllers/settings.controller.binding.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () =>  HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () =>  SettingsScreen(),
      binding: SettingsControllerBinding(),
    ),
    GetPage(
      name: Routes.BMI_CALCULATOR,
      page: () =>  BmiCalculatorScreen(),
      binding: BmiCalculatorControllerBinding(),
    ),
    GetPage(
      name: Routes.BMI_HISTORY,
      page: () =>  BmiHistoryScreen(),
      binding: BmiHistoryControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_LOG_MEALS,
      page: () =>  AddLogMealScreen(),
      binding: AddLogMealControllerBinding(),
    ),
  ];
}
