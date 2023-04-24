import '../../home_screen/home.dart';

// ignore: must_be_immutable
class SwitchWithTitleWidget extends StatefulWidget {
  bool value;
  final String label;
  Function(bool)? onChanged;
  SwitchWithTitleWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  State<SwitchWithTitleWidget> createState() => _SwitchWithTitleWidgetState();
}

class _SwitchWithTitleWidgetState extends State<SwitchWithTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Switch(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
