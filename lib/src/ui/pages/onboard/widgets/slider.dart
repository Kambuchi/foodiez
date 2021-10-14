import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodiez/src/utils/font_styles.dart';
import 'package:provider/provider.dart';
import '../onboard_controller.dart';
import '../../../../data/models/onboard_item.dart';

class OnboardSlider extends StatelessWidget {
  const OnboardSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context, listen: false);

    return Expanded(
      child: PageView(
        controller: controller.pageController,
        children: List.generate(
          controller.items.length,
          (index) {
            final OnboardItem item = controller.items[index];
            return Container(
              child: Column(
                children: [
                  Expanded(child: SvgPicture.asset(item.image)),
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: FontStyles.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      item.description,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
