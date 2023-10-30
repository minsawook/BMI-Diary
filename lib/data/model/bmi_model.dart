
import 'dart:convert';

import 'package:hive_flutter/adapters.dart';

part 'bmi_model.g.dart';


BmiModel bmiModelFromJson(String str) => BmiModel.fromJson(json.decode(str));

String bmiModelToJson(BmiModel data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class BmiModel {
  @HiveField(0)
  double bmi;

  @HiveField(1)
  double weight;

  @HiveField(2)
  String time;

  @HiveField(3)
  List<dynamic> diet;

  BmiModel({
    required this.bmi,
    required this.weight,
    required this.time,
    required this.diet,
  });

  factory BmiModel.fromJson(Map<String, dynamic> json) => BmiModel(
    bmi: json["bmi"]?.toDouble(),
    weight: json["weight"]?.toDouble(),
    time: json["time"],
    diet: List<dynamic>.from(json["diet"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bmi": bmi,
    "weight": weight,
    "time": time,
    "diet": List<dynamic>.from(diet.map((x) => x)),
  };
}
