import '../../home_screen/home.dart';

// ignore: must_be_immutable
class CustomDropdownMenu extends StatefulWidget {
  String dropdownValue;
  final List<String> menuList;
  final String textLabel;
  Function(String?)? onChanged;
  CustomDropdownMenu({
    super.key,
    required this.dropdownValue,
    required this.menuList,
    required this.textLabel,
    required this.onChanged,
  });

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textLabel,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        DropdownButton<String>(
          alignment: Alignment.centerLeft,
          value: widget.dropdownValue,
          onChanged: widget.onChanged,
          items: widget.menuList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
