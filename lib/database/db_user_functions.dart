import 'package:for_you/models/user_model.dart';
import 'package:hive/hive.dart';

//Box for storing data
final Future<Box<User>> _userBox = Hive.openBox<User>('users');

Future<Box<User>> boxCurrentUser = Hive.openBox('currentUser');
// savecurrentUser(User user) async {
//   var box = await boxCurrentUser;
//   box.put('data', user);
//   print('111111111111111111111111111');
//   print("${user.username}  ${user.password}  key== ${user.key}");
//   box.close();
// }

// Retrieve Current user
retrieveCurrentUser() async {
  final Future<Box<User>> userBox = Hive.openBox<User>('users');
  final Box<User> curretUser = await userBox;
  User? user = curretUser.get(int.parse(currentUserKey!));
  if (user != null) {
    return user;
  } else {
    return null;
  }
}

User currentUser = User(username: 'demoUser', password: 'demopass');

Future getcurrentUser() async {
  Box<User> box = await boxCurrentUser;
  User? getuser = box.get('data');

  if (getuser != null) {
    currentUser = getuser;

    await box.close();
    return getuser;
  } else {
    await box.close();
    return null;
  }
}

// save account
Future storeUserData(User user) async {
  final Box<User> userBox = await _userBox;
  int key = await userBox.add(user);
  currentUserKey = key.toString();
  await saveCurrentUserKey(key.toString());
}

// check and login
Future<bool> validateUserData(String username, String password) async {
  final Box<User> userBox = await _userBox;
  List<User> allUsers = userBox.values.toList();

  List<User> usernamematchingUsers =
      allUsers.where((user) => user.username == username).toList();

  bool passwordMatches =
      usernamematchingUsers.any((user) => user.password == password);
  if (passwordMatches) {
    currentUser =
        usernamematchingUsers.firstWhere((user) => user.password == password);

    await saveCurrentUserKey(currentUser.key.toString());
    return true;
  } else {
    return false;
  }
}
// Future <>

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

  checkLogin.put(data, login);
}

Future<bool?> checkLogin() async {
  String data = 'data';
  final checkLogin = await _userLogin;
  bool? checkedLogin = checkLogin.get(data);
  checkedLogin ??= false;
  return checkedLogin;
}

//currentkey
String? currentUserKey;

// Save the current user key to the box
Future<void> saveCurrentUserKey(String key) async {
  Box<String> box = await Hive.openBox('saveCurrentUserKey');

  await box.put('currentKey', key);
  await box.close();
  getCurrentUserKey();
}

//edit user

Future<void> editUserName(String name) async {
  final userBox = await Hive.openBox<User>('users');
  final user = userBox.get(int.parse(currentUserKey!));
  user?.name = name;
  userBox.put(int.parse(currentUserKey!), user!);
}

// Retrieve the current user key from the box
Future<String?> getCurrentUserKey() async {
  Box<String> box = await Hive.openBox('saveCurrentUserKey');
  String? currentKey = box.get('currentKey');

  currentUserKey = currentKey;

  return currentKey;
}

// Function to store image data

Future<void> setImage(String imagePath) async {
  final userBox = await Hive.openBox<User>('users');
  final user = userBox.get(int.parse(currentUserKey!));
  user?.imageData = imagePath; // Store image path as string
  userBox.put(int.parse(currentUserKey!), user!);
}

// Function to retrieve image path
Future<String?> getImage() async {
  final userBox = await Hive.openBox<User>('users');
  final User? user = userBox.get(int.parse(currentUserKey!));
  return user?.imageData; // Retrieve image path as string
}
