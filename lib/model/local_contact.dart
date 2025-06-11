import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LocalContact extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  LocalContact({required this.name, required this.phone});
}