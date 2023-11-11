// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BmiModelAdapter extends TypeAdapter<BmiModel> {
  @override
  final int typeId = 1;

  @override
  BmiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BmiModel(
      bmi: fields[0] as double,
      weight: fields[1] as double,
      time: fields[2] as String,
      diet: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, BmiModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.bmi)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.diet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BmiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
