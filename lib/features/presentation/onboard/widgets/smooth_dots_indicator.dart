import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothDotsIndicator extends StatelessWidget {
  final PageController controller;
  final int itemCount;

  const SmoothDotsIndicator({
    super.key,
    required this.itemCount,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // example

    return SmoothPageIndicator(
      controller: controller,
      count: itemCount,
      effect: JumpingDotEffect(
        activeDotColor: Colors.brown.shade200,
        dotColor: Colors.grey,
        dotHeight: 10.0,
        dotWidth: 10.0,
      ),
    );
  }
}
