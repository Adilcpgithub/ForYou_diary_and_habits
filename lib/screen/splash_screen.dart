import 'package:flutter/material.dart';
import 'package:for_you/database/db_user_functions.dart';
import 'package:for_you/database/dp_f_diary_entry.dart';
import 'package:for_you/database/habit_db.dart';
import 'package:for_you/screen/infopages.dart';
import 'package:for_you/screen/button_bar/button_bar_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? keyIns = currentUserKey;
  @override
  void initState() {
    //  gotoInfopage();
    initializeCurrentUser();
    initialiseHabit();
    // print("cccccccc${currentUserKey}");
    gotoNextPage();
    // loadAllDataWithkey();
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
                  fontSize: 60, fontFamily: 'Monoton', color: Colors.blue[300]),
            ),
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/Newbook(foryou).png',
              height: 120,
              width: 120,
              color: Colors.blue[300],
            )
          ],
        ),
      ),
    );
  }

  gotoInfopage() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return const PageOne();
    }), (route) => false);
  }

  gotoDemoPage() async {
    await Future.delayed(
      const Duration(seconds: 5),
    );
    // await getAllEntries(currentUserKey!);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
      return MyHomePage(
        selectedIndex: 0,
      );
    }), (route) => false);
  }

  gotoNextPage() async {
    bool? isLogin = await checkLogin();
    Future.delayed(
      const Duration(seconds: 5),
    );
    //  await getAllEntries(currentUserKey!);

    if (isLogin == true || isLogin == null) {
      gotoDemoPage();
    } else {
      gotoInfopage();
    }
  }

  loadAllDataWithkey() async {
    await getAllEntries(currentUserKey!);
  }

  initializeCurrentUser() async {
    await getCurrentUserKey();
  }

  initialiseHabit() async {
    HabitDBFunctions obj = HabitDBFunctions();
    await obj.getHabbit();
  }
}
