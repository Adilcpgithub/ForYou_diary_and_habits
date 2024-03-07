import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0, adapterName: 'UserAdapter')
class User extends HiveObject {
  @HiveField(0)
  late String username;
  @HiveField(1)
  late String password;
  User(this.username, this.password);
}
