import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/bmi_history.controller.dart';

class BmiHistoryScreen extends GetView<BmiHistoryController> {
  const BmiHistoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BmiHistoryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BmiHistoryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
