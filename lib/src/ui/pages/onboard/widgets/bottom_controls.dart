import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../onboard_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';

class OnboardControls extends StatelessWidget {
  const OnboardControls({
    Key? key,
  }) : super(key: key);

  void _onNext(BuildContext context, OnboardController controller) {
    if (controller.currentPage == 2.0) {
      Navigator.pushReplacementNamed(context, Routes.WELCOME);
    } else {
      controller.pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Dots(),
          Consumer<OnboardController>(
            builder: (_, controller, __) {
              final double page = controller.currentPage;
              bool isEnd = page % 1 == 0 && page == 2.0;
              return CupertinoButton(
                child: Container(
                  child: Text(
                    isEnd ? 'Empezar' : 'Siguiente',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  this._onNext(context, controller);
                },
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();
    return Container(
        child: DotsIndicator(
      dotsCount: controller.items.length,
      position: controller.currentPage,
      decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          color: Colors.grey.shade100,
          activeColor: primaryColor,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          )),
    ));
  }
}
