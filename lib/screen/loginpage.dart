import 'package:flutter/material.dart';
import 'package:for_you/database/db_functions.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';
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
              SizedBox(
                height: 200,
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
                      height: 40,
                    ),
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          checkUser = userController.text.isEmpty;
                          checkPassword = passwordController.text.isEmpty;
                        });
                        if (userController.text.length >= 4) {
                          if (passwordController.text.length >= 6) {
                            //////////
                            var login = await validateUserData(
                                userController.text, passwordController.text);
                            print(login);

                            if (login == true) {
                              setCheckLogin(true);
                              GotoDd(context);
                            } else {
                              showSnackBar(context, 'Wrong entry', Colors.red);
                            }
                            /////
                          } else {
                            showSnackBar(context, 'password Should be 6 Number',
                                Colors.red);
                          }
                        } else {
                          showSnackBar(context,
                              'usesname Should be 4 character', Colors.red);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: AppColors.modelwhite,
                            fontFamily: Textfonts.MiseryRegular,
                            fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.modelColor1,
                          minimumSize: Size(150, 50)),
                    ),
//////////////////////////////////////////////////////

                    //////////////////////////////////////////////////////////////////// //////
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => GotoSignPage(context),
                        child: Text('Register')),
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

GotoSignPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return Sign_In();
    ////chane page route name/////
  }), (route) => false);
}

GotoDd(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return EntryList();
    ////chane page route name/////
  }), (route) => false);
}
