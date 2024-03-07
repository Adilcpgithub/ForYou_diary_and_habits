import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:for_you/screen/loginpage.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';

////////////////////////// first information page//////////////////////////////////////////////
class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  var currentIndux = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'assets/images/victore_diary.jpg',
      'assets/images/habtis.jpg',
      'assets/images/All in one appp.jpg'
    ];
    List<String> textList = [
      'Express your feeling',
      'Create good habits',
      ' All in one app'
    ];
    List<String> textNoteList = [
      "write your diary and express \n                your feeling",
      "Create good habits and track their \n                progress over time ",
      "Make your day better\n"
    ];

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FOR YOU",
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: Textfonts.Monoton,
                  color: Colors.green),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.asset(
                imageList[currentIndux],
                height: 250,
                width: 250,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              textList[currentIndux],
              style: TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontFamily: Textfonts.ConformityPersonalUseRegular,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              textNoteList[currentIndux],
              style: TextStyle(
                fontSize: 18,
                color: AppColors.modelColor1,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndux = 0;
                    });
                  },
                  child: Container(
                    height: 15,
                    width: 0 == currentIndux ? 50 : 15,
                    decoration: BoxDecoration(
                      color: 0 == currentIndux
                          ? AppColors.modelColor1
                          : AppColors.modelColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndux = 1;
                    });
                  },
                  child: Container(
                    height: 15,
                    width: 1 == currentIndux ? 50 : 15,
                    decoration: BoxDecoration(
                      color: 1 == currentIndux
                          ? AppColors.modelColor1
                          : AppColors.modelColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentIndux = 2;
                    });
                  },
                  child: Container(
                    height: 15,
                    width: 2 == currentIndux ? 50 : 15,
                    decoration: BoxDecoration(
                      color: 2 == currentIndux
                          ? AppColors.modelColor1
                          : AppColors.modelColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            currentIndux != 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => GotoLoginPage(context),
                        child: Container(
                          child: Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                fontFamily: Textfonts.MiseryRegular,
                                color: AppColors.modelColor1,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 204, 248, 206),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndux++;
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontFamily: Textfonts.MiseryRegular,
                                  color: AppColors.modelwhite,
                                  fontSize: 20),
                            ),
                          ),
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: AppColors.modelColor1,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                          ),
                        ),
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () => GotoLoginPage(context),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Let's Go",
                          style: TextStyle(
                              fontFamily: Textfonts.MiseryRegular,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(30, 30)),
                      ),
                    ),
                  )
          ],
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
