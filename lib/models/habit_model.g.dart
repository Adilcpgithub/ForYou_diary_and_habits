// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitModelAdapter extends TypeAdapter<HabitModel> {
  @override
  final int typeId = 2;

  @override
  HabitModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HabitModel(
      habbitName: fields[0] as String,
      habbitQuestion: fields[1] as String?,
      habbitCompleted: (fields[2] as Map?)?.cast<DateTime, bool>(),
      remainder: fields[3] as TimeOfDay?,
      userId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HabitModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.habbitName)
      ..writeByte(1)
      ..write(obj.habbitQuestion)
      ..writeByte(2)
      ..write(obj.habbitCompleted)
      ..writeByte(3)
      ..write(obj.remainder)
      ..writeByte(4)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}