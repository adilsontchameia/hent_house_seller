import '../../home_screen/home.dart';

class CustomIntDropdownMenu extends StatefulWidget {
  final int dropdownValue;
  final List<int> menuList;
  final String textLabel;
  final Function(int?)? onChanged;

  const CustomIntDropdownMenu({
    Key? key, // Add the 'Key?' parameter here
    required this.dropdownValue,
    required this.menuList,
    required this.textLabel,
    required this.onChanged,
  }) : super(key: key); // Initialize the 'key' parameter in the constructor

  @override
  State<CustomIntDropdownMenu> createState() => _CustomIntDropdownMenuState();
}

class _CustomIntDropdownMenuState extends State<CustomIntDropdownMenu> {
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
        DropdownButton<int>(
          alignment: Alignment.centerLeft,
          value: widget.dropdownValue,
          onChanged: widget.onChanged,
          items: widget.menuList.map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
