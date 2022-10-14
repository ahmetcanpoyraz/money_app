import 'package:hive/hive.dart';

part 'lang_hive.g.dart';

@HiveType(typeId: 1)
class LangHive {
  @HiveField(0)
  String? langSelected;
}