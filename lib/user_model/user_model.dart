

import 'package:hive_ce/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel  extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final bool scanned;

  UserModel({
    required this.date,
    required this.email,
    required this.phone,
    required this.id,
    required this.name,
    this.scanned = false,
  });
}