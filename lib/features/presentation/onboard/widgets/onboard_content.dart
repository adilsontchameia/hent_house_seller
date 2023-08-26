import 'package:flutter/material.dart';

class OnboardTextContent extends StatelessWidget {
  const OnboardTextContent({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.brown.shade100),
    );
  }
}

class OnboardTitles extends StatelessWidget {
  const OnboardTitles({
    super.key,
    required PageController controller,
    required this.titlesList,
  }) : _controller = controller;

  final PageController _controller;
  final List<Widget> titlesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: PageView(
            controller: _controller,
            children: titlesList,
          ),
        ));
  }
}
