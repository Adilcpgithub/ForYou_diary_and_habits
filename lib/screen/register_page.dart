import 'package:flutter/material.dart';
import 'package:for_you/database/db_functions.dart';
import 'package:for_you/models/user_model.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
import 'package:for_you/screen/loginpage.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';
import 'package:for_you/widget/textformfield.dart';

class Sign_In extends StatefulWidget {
  const Sign_In({super.key});

  @override
  State<Sign_In> createState() => _Sign_InState();
}

class _Sign_InState extends State<Sign_In> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              SizedBox(
                height: 150,
              ),
              Container(
                height: 100,
                width: 100,
                child: Image.asset(
                  'assets/images/Newbook(foryou).png',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
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
                      color: AppColors.modelColor2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextformfeildModel(
                      keyboardType: TextInputType.number,
                      validator: checkPassword,
                      controller: passwordController,
                      hintText: '  EnterPassword',
                      borderRadius: 30,
                      errorText: "Password Can't be null",
                      color: AppColors.modelColor2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextformfeildModel(
                      keyboardType: TextInputType.number,
                      validator: checkPassword,
                      controller: ConformPasswordController,
                      hintText: '  ConformPassword',
                      borderRadius: 30,
                      errorText: "ConformPassword Can't be null",
                      color: AppColors.modelColor2,
                    ),
                    SizedBox(
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
                          child: Text(
                            'clear data',
                            style: TextStyle(
                                color: AppColors.modelblack,
                                fontFamily: Textfonts.MiseryRegular,
                                fontSize: 15),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: AppColors.modelwhite,
                              minimumSize: Size(150, 50)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          checkUser = userController.text.isEmpty;
                          checkPassword = passwordController.text.isEmpty;
                          checkConformPassword =
                              ConformPasswordController.text.isEmpty;
                        });
                        if (passwordController.text ==
                            ConformPasswordController.text) {
                          if (userController.text.isNotEmpty &&
                              passwordController.text != '') {
                            if (userController.text.length >= 4) {
                              if (passwordController.text.length >= 6 &&
                                  ConformPasswordController.text.length >= 6) {
                                storeUserData(User(userController.text,
                                    passwordController.text));
                                GotoDd(context);
                              } else {
                                showSnackBar(
                                    context,
                                    'password Should be 6 Number',
                                    const Color.fromARGB(255, 236, 83, 72));
                              }
                            } else {
                              showSnackBar(
                                  context,
                                  'usesname Should be 4 character',
                                  const Color.fromARGB(255, 236, 83, 72));
                            }
                          }
                        } else {
                          showSnackBar(context, 'Wrong conform password ',
                              const Color.fromARGB(255, 236, 83, 72));
                        }
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: AppColors.modelwhite,
                            fontFamily: Textfonts.MiseryRegular,
                            fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.modelColor1,
                          minimumSize: Size(150, 50)),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => GotoLoginPage(context),
                        child: Text('Go to login')),
                    SizedBox(
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
}

GotoLoginPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return LoginPage();
    ////chane page route name/////
  }), (route) => false);
}

GotoDd(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return EntryList();
    ////chane page route name/////
  }), (route) => false);
}
