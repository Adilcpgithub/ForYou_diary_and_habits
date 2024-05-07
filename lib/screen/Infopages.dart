// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:for_you/screen/register_page.dart';
import 'package:for_you/widget/Colors_SnackBar.dart';
import 'package:for_you/widget/textfont_model.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  var currentIndux = 0;
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'assets/images/info diary img.jpg',
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
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "FOR YOU",
              style: TextStyle(
                  fontSize: 50,
                  fontFamily: Textfonts.Monoton,
                  color: Colors.blue[300]),
            ),
            Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageList[currentIndux]),
                ),
                borderRadius:
                    BorderRadius.circular(20.0), // Set border radius to 60
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              textList[currentIndux],
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue[300],
                fontWeight: FontWeight.w500,
                fontFamily: Textfonts.ConformityPersonalUseRegular,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              textNoteList[currentIndux],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
            const SizedBox(
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
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
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
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
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
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            currentIndux != 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => GotoLoginPage(context),
                        child: Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
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
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndux++;
                          });
                        },
                        child: Container(
                          height: 60,
                          width: 130,
                          decoration: BoxDecoration(
                            color: AppColors.modelColor1,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30)),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              style: TextStyle(
                                  fontFamily: Textfonts.MiseryRegular,
                                  color: AppColors.modelwhite,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : GestureDetector(
                    onTap: () => GotoLoginPage(context),
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        color: AppColors.modelColor1,
                        borderRadius:
                            const BorderRadius.all(Radius.elliptical(30, 30)),
                      ),
                      child: Center(
                        child: Text(
                          "Let's Go",
                          style: TextStyle(
                              fontFamily: Textfonts.MiseryRegular,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
GotoLoginPage(ctx) {
  Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) {
    return const Sign_In();
    ////chane page route name/////
  }), (route) => false);
}
