// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lang_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LangHiveAdapter extends TypeAdapter<LangHive> {
  @override
  final int typeId = 1;

  @override
  LangHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LangHive()..langSelected = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, LangHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.langSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LangHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
