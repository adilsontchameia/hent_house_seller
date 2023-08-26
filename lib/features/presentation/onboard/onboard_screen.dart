import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/presentation/onboard/widgets/get_started_button.dart';
import 'package:hent_house_seller/features/presentation/onboard/widgets/image_list_view.dart';
import 'package:hent_house_seller/features/presentation/onboard/widgets/onboard_content.dart';
import 'package:hent_house_seller/features/presentation/onboard/widgets/smooth_dots_indicator.dart';
import 'package:hent_house_seller/features/presentation/providers/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class OnboardScreen extends StatefulWidget {
  static const routeName = "/onboard-screen";
  OnboardScreen({
    super.key,
  });

  final List<Widget> titlesList = [
    const OnboardTextContent(
      title: 'Procure pelo teu próximo cúbico com apenas um click.',
    ),
    const OnboardTextContent(
      title:
          'Registra-se com seu número de telefone, e troque mensagens com o vendedor, na maior calma.',
    ),
    const OnboardTextContent(
      title: 'Todos vendedores aqui, são confiáveis, e verificados.',
    ),
  ];

  @override
  OnboardScreenState createState() => OnboardScreenState();
}

class OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController();
  int _currentPageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startAutoScroll();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    _cancelAutoScroll();
    super.dispose();
  }

  // Function to start auto-scrolling
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPageIndex < widget.titlesList.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _controller.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // Function to cancel auto-scrolling
  void _cancelAutoScroll() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // Get access to the UserDataProvider using Provider
    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    // Fetch the user data when the app starts
    userDataProvider.getCurrentUserData();
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: -10,
            left: -120,
            child: Row(
              children: [
                ImageListView(startIndex: 0),
                ImageListView(startIndex: 1),
                ImageListView(startIndex: 2),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.60,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mô Cúbico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade200,
                      letterSpacing: 5,
                    ),
                  ),
                  OnboardTitles(
                    controller: _controller,
                    titlesList: widget.titlesList,
                  ),
                  SmoothDotsIndicator(
                    controller: _controller,
                    itemCount: widget.titlesList.length,
                  ),
                ],
              ),
            ),
          ),
          const GetStartedButton(),
        ],
      ),
    );
  }
}
