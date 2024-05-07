import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/screen/button_bar/button_bar_home.dart';
import 'package:for_you/screen/register_page.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:for_you/widget/textformfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool checkUser = false;
  bool checkPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/Newbook(foryou).png',
                  fit: BoxFit.cover,
                  color: Colors.blue[300],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  children: [
                    TextformfeildModel(
                      validator: checkUser,
                      controller: userController,
                      hintText: '  Enter UserName',
                      borderRadius: 30,
                      errorText: "UserName Can't be null",
                      color: const Color.fromARGB(255, 153, 206, 250),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextformfeildModel(
                      validator: checkPassword,
                      controller: passwordController,
                      hintText: '  EnterPassword',
                      borderRadius: 30,
                      errorText: "Password Can't be null",
                      color: const Color.fromARGB(255, 153, 206, 250),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              userController.text = '';
                              passwordController.text = '';
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.modelwhite,
                              minimumSize: const Size(150, 50)),
                          child: Text(
                            'clear data',
                            style: TextStyle(
                                color: AppColors.modelblack,
                                fontFamily: Textfonts.MiseryRegular,
                                fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          checkUser = userController.text.isEmpty;
                          checkPassword = passwordController.text.isEmpty;
                        });
                        login(userController.text, passwordController.text);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.modelColor1,
                          minimumSize: const Size(150, 50)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppColors.modelwhite,
                            fontFamily: Textfonts.MiseryRegular,
                            fontSize: 20),
                      ),
                    ),
//////////////////////////////////////////////////////

                    //////////////////////////////////////////////////////////////////// //////
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => GotoSignPage(context),
                        child: const Text('Register')),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidUsername(String username) {
    final RegExp usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    return usernameRegExp.hasMatch(username);
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegExp =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegExp.hasMatch(password);
  }

  void login(String username, String password) async {
    if (isValidUsername(username)) {
      if (isValidPassword(password)) {
        bool loginSuccess = await validateUserData(username, password);
        if (!loginSuccess) {
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'Wrong username or password', Colors.red);
        } else {
          setCheckLogin(true);

          await getCurrentUserKey();

          saveCurrentUserKey(currentUser.key.toString());
          // ignore: use_build_context_synchronously
          GotoDd(context);
        }
      } else {
        showSnackBar(
            context,
            'Password should be at least 6 characters long and contain at least one letter and one digit',
            Colors.red);
      }
    } else {
      showSnackBar(
          context,
          'Username should contain only alphanumeric characters and underscores',
          Colors.red);
    }
  }
}

// ignore: non_constant_identifier_names
GotoSignPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return const Sign_In();
  }), (route) => false);
}

// ignore: non_constant_identifier_names
GotoDd(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return MyHomePage(
      selectedIndex: 0,
    );
  }), (route) => false);
}
