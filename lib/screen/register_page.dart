import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/models/user_model.dart';
import 'package:for_you/screen/button_bar/button_bar_home.dart';
import 'package:for_you/screen/loginpage.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:for_you/widget/textformfield.dart';

// ignore: camel_case_types
class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

// ignore: camel_case_types
class _Sign_InState extends State<Sign_In> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController ConformPasswordController = TextEditingController();
  bool checkUser = false;
  bool checkPassword = false;
  bool checkConformPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
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
                      height: 30,
                    ),
                    TextformfeildModel(
                      validator: checkPassword,
                      controller: ConformPasswordController,
                      hintText: '  ConformPassword',
                      borderRadius: 30,
                      errorText: "ConformPassword Can't be null",
                      color: const Color.fromARGB(255, 153, 206, 250),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              userController.text = '';
                              passwordController.text = '';
                              ConformPasswordController.text = '';
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
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          checkUser = userController.text.isEmpty;
                          checkPassword = passwordController.text.isEmpty;
                          checkConformPassword =
                              ConformPasswordController.text.isEmpty;
                        });

                        if (userController.text.isNotEmpty &&
                            passwordController.text != '') {
                          if (passwordController.text.length >= 6 &&
                              ConformPasswordController.text.length >= 6) {
                            if (passwordController.text ==
                                ConformPasswordController.text) {
                              bool data = await validateUserData(
                                  userController.text, passwordController.text);
                              if (data) {
                                // ignore: use_build_context_synchronously
                                showSnackBar(context, 'User already exists',
                                    const Color.fromARGB(255, 236, 83, 72));
                              } else {
                                if (isValidUsername(userController.text)) {
                                  if (isValidPassword(
                                      passwordController.text)) {
                                    await storeUserData(User(
                                        username: userController.text,
                                        password: passwordController.text));
                                    setCheckLogin(true);
                                    // ignore: use_build_context_synchronously
                                    GotoDd(context);
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    showSnackBar(
                                        context,
                                        'Password should be at least 6 characters long and contain at least one letter and one digit',
                                        Colors.red);
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  showSnackBar(
                                      context,
                                      'Username should contain only alphanumeric characters and underscores',
                                      Colors.red);
                                }
                              }
                            } else {
                              showSnackBar(context, 'wrong conform password',
                                  const Color.fromARGB(255, 236, 83, 72));
                            }
                          } else {
                            showSnackBar(context, 'password Should be 6 Number',
                                const Color.fromARGB(255, 236, 83, 72));
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.modelColor1,
                          minimumSize: const Size(150, 50)),
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: AppColors.modelwhite,
                            fontFamily: Textfonts.MiseryRegular,
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => GotoLoginPage(context),
                        child: const Text('Go to login')),
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
}

// ignore: non_constant_identifier_names
GotoLoginPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return const LoginPage();
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
