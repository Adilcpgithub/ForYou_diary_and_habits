import 'package:flutter/material.dart';
import 'package:for_you/database/db_functions.dart';
import 'package:for_you/screen/Infopages.dart';
import 'package:for_you/screen/diary_page/entry_list.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //  gotoInfopage();
    gotoNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FOR YOU",
              style: TextStyle(
                  fontSize: 60, fontFamily: 'Monoton', color: Colors.green),
            ),
            SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/Newbook(foryou).png',
              height: 120,
              width: 120,
            )
          ],
        ),
      ),
    );
  }

  gotoInfopage() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return PageOne();
    }), (route) => false);
  }

  gotoDemoPage() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return EntryList();
    }), (route) => false);
  }

  gotoNextPage() async {
    bool? isLogin = await CheckLogin();
    Future.delayed(
      Duration(seconds: 1),
    );

    if (isLogin == true) {
      gotoDemoPage();
    } else {
      gotoInfopage();
    }
  }
}
