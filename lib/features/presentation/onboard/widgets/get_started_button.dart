import 'package:flutter/material.dart';
import 'package:hent_house_seller/features/presentation/bottom_navigation_pages/bottom_navigation_screen.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 30.0,
        left: 20.0,
        right: 20.0,
        child: SizedBox(
          height: 50.0,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    const BottomNavigationScreens(),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text(
              'Iniciar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ));
  }
}
