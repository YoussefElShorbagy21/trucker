import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/chose_app/chose_app.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:login/shared/resources/asset_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/resources/color_manager.dart';
import '../Login Screen/loginScreen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: ImageAssets.kOnBoarding1,
      title: 'on_boarding_title1',
      body: 'on_boarding_desc1',
    ),
    BoardingModel(
      image: ImageAssets.kOnBoarding2,
      title: 'on_boarding_title2',
      body: 'on_boarding_desc2',
    ),
    BoardingModel(
      image: ImageAssets.kOnBoarding3,
      title: 'on_boarding_title3',
      body: 'on_boarding_desc3',
    ),
  ];

  bool isLast = false;

  void submit(context) {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.saveData(
                key: 'onBoarding',
                value: true,
              ).then((value) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const ChoseApp()));
              });
            },
            child: Text(
              'skip'.tr(context),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: ColorManager.kGold,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => const ChoseApp()));
                      submit(context);
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  backgroundColor: ColorManager.kGray,
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title.tr(context),
            style: TextStyle(
              color: ColorManager.black,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body.tr(context),
            style: TextStyle(
              color: ColorManager.black,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
