import 'package:for_you/models/user_model.dart';
import 'package:hive/hive.dart';

//Box for storing data
final Future<Box<User>> _userBox = Hive.openBox<User>('users');

// save account
void storeUserData(User user) async {
  final Box<User> userBox = await _userBox;
  userBox.put(user.username, user);
  print('data saved');
}

late String currentUser;
// check and login
Future<bool> validateUserData(String username, String password) async {
  final Box<User> userBox = await _userBox;
  bool data;
  final user = userBox.get(username);

  if (user != null && user.password == password) {
    currentUser = user.key;
    print('adil you got the key ====== ${currentUser}');
    data = true;
  } else {
    data = false;
  }
  return data;
}

// delet your persistent  accont
bool deleteAccont(String username, String password) {
  final userBox = Hive.box<User>('users');
  final user = userBox.get(username);
  if (user != null && user.password == password) {
    userBox.delete(username);
    return true;
  } else {
    return false;
  }
}

final Future<Box<bool>> _userLogin = Hive.openBox<bool>('user');

setCheckLogin(bool login) async {
  String data = 'data';
  final checkLogin = await _userLogin;
  print('setting');
  print(login);
  checkLogin.put(data, login);
  print('${login} setted');
}

Future<bool?> CheckLogin() async {
  String data = 'data';
  final checkLogin = await _userLogin;
  bool? checkedLogin = checkLogin.get(data);
  return checkedLogin;
}
