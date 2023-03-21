import 'widgets.dart';

class SellerBages extends StatelessWidget {
  const SellerBages(
      {super.key,
      required this.state,
      required this.icon,
      required this.containerColor});

  final bool state;
  final IconData icon;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state,
      child: Container(
        height: 12.0,
        width: 12.0,
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 11,
          color: Colors.white,
        ),
      ),
    );
  }
}
