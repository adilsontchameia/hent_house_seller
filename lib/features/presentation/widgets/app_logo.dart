import 'widgets.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      width: 110.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Stack(
        children: [
          Positioned(
              left: 10.0,
              right: 10.0,
              child: Column(
                children: [
                  Icon(
                    Icons.home_filled,
                    size: 80.0,
                    color: Colors.brown,
                  ),
                  Text(
                    'Mô Cúbico',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.brown,
                      letterSpacing: 5,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
