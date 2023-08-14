import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hent_house_seller/features/presentation/bottom_navigation_pages/widgets/tab_icons.dart';
import 'package:hent_house_seller/features/presentation/list_chat_messages/list_chat_messages_screen.dart';
import 'package:hent_house_seller/features/presentation/filtered_advertisiment/filtered_advertisiment_screen.dart';
import 'package:hent_house_seller/features/presentation/home_screen/home_screen.dart';
import 'package:hent_house_seller/features/presentation/profile/profile_screen.dart';

class BottomNavigationScreens extends StatefulWidget {
  static const routeName = '/bottom-navigation-screens';
  const BottomNavigationScreens({super.key});

  @override
  State<BottomNavigationScreens> createState() =>
      _BottomNavigationScreensState();
}

final tabIcons = [
  FontAwesomeIcons.house,
  FontAwesomeIcons.chartSimple,
  FontAwesomeIcons.message,
  FontAwesomeIcons.user,
];

final appPages = [
  HomeResumeScreen(),
  const FilteredAdvertisimentScreen(),
  ListChatMessagesScreen(),
  ProfileScreen(),
];

class _BottomNavigationScreensState extends State<BottomNavigationScreens> {
  int currentIndex = 0;
  bool isVisible = true;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: appPages,
            ),
            Stack(
              children: [
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.bounceInOut,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...tabIcons.asMap().entries.map(
                                  (entry) => TabIcons(
                                    isSelected: currentIndex == entry.key,
                                    iconData: entry.value,
                                    onTap: () {
                                      pageController.animateToPage(
                                        duration: const Duration(
                                          milliseconds: 350,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        entry.key,
                                      );
                                      setState(() {
                                        currentIndex = entry.key;
                                      });
                                    },
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20.0,
              right: 2.0,
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.brown,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (isVisible) {
                        isVisible = false;
                      } else {
                        isVisible = true;
                      }
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? FontAwesomeIcons.downLeftAndUpRightToCenter
                        : FontAwesomeIcons.upRightAndDownLeftFromCenter,
                    color: Colors.white,
                    size: 15.0,
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
