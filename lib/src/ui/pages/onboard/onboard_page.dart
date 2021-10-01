import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'onboard_controller.dart';
import 'widgets/slider.dart';
import 'widgets/bottom_controls.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {  
    return ChangeNotifierProvider<OnboardController>(
      create: (_) {
        final controller = OnboardController();
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          controller.afterFirstLayout();
        });
        return controller;
      },
      builder: (context, __) => Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                OnboardSlider(),
                Container(
                  margin: EdgeInsets.all(15),
                  child: OnboardControls(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
