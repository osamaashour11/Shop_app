import 'package:flutter/material.dart';
import 'package:flutter_shop_app/modules/login_screen/Login_screen.dart';
import 'package:flutter_shop_app/shared/components/components.dart';
import 'package:flutter_shop_app/shared/constants/constants.dart';
import 'package:flutter_shop_app/shared/network/local/shared_preferences/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModelScreens> onBoardingScreenList = [
    OnBoardingModelScreens(
      image: 'assets/images/on_b_1.png',
      title: 'Life isn’t perfect but your outfit can be',
      body:
          'shop is very familiar palace to us. A shop is available in the place where people live or use to move around.',
    ),
    OnBoardingModelScreens(
      image: 'assets/images/on_b_2.png',
      title: 'Buy now or cry later',
      body:
          'In market or Haat we find many shops together. Usually a shop is well decorated.',
    ),
    OnBoardingModelScreens(
      image: 'assets/images/on_b_3.png',
      title: 'Shopping is always a good idea',
      body:
          'We go to a shop to buy our daily necessities. A shop sells retail products. There are some temporary shops around us.',
    ),
  ];

  var pageController = PageController();

  bool lastScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defultTextButton(
              onPressed: submit,
              text: 'Skip',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (index) {
                    if (index == onBoardingScreenList.length - 1) {
                      setState(() {
                        lastScreen = true;
                      });
                    } else {
                      setState(() {
                        lastScreen = false;
                      });
                    }
                  },
                  controller: pageController,
                  itemBuilder: (context, index) =>
                      defultOnBoardingItem(onBoardingScreenList[index]),
                  itemCount: onBoardingScreenList.length,
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: defultApplicationColor,
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      expansionFactor: 5,
                    ),
                    count: onBoardingScreenList.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (lastScreen) {
                        submit();
                      } else {
                        pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: lastScreen
                        ? defultText(
                            text: 'GO',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                        : const Icon(
                            Icons.arrow_forward_ios,
                          ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      navigateTo(
        context,
        LoginScreen(),
      );
    }).catchError((error) {
      print(error.toString());
    });
  }

  Widget defultOnBoardingItem(OnBoardingModelScreens onBoardingModelScreens) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: AssetImage(
                  onBoardingModelScreens.image,
                ),
              ),
            ),
            defultText(
              text: onBoardingModelScreens.title,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: defultApplicationColor,
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 20,
            ),
            defultText(
              text: onBoardingModelScreens.body,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              maxLines: 3,
              textOverflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
}

class OnBoardingModelScreens {
  final String image;
  final String title;
  final String body;

  OnBoardingModelScreens({
    required this.image,
    required this.title,
    required this.body,
  });
}
