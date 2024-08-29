import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart' as action;

class ActionSlider extends StatelessWidget {
  const ActionSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return action.ActionSlider.standard(
      sliderBehavior: action.SliderBehavior.stretch,
      icon: const Icon(
        Icons.keyboard_arrow_right,
        color: Colors.white,
        size: 30,
      ),
      successIcon: const Icon(Icons.check_rounded, color: Colors.white),
      toggleColor: Colors.pink,
      backgroundColor: Colors.white,
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(seconds: 3));
        controller.success();
        await Future.delayed(const Duration(seconds: 1));
        controller.reset();
      },
      child: const Text(
        'Slide to confirm',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
