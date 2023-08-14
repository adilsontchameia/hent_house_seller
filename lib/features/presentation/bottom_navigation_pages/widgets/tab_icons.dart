import 'package:flutter/material.dart';

class TabIcons extends StatefulWidget {
  final bool isSelected;
  final IconData iconData;
  final VoidCallback onTap;

  const TabIcons({
    super.key,
    required this.isSelected,
    required this.iconData,
    required this.onTap,
  });

  @override
  TabIconsState createState() => TabIconsState();
}

class TabIconsState extends State<TabIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: IconButton(
        onPressed: widget.onTap,
        icon: Icon(
          widget.iconData,
          color: widget.isSelected ? Colors.white : Colors.grey,
          size: widget.isSelected ? 30 : 18,
        ),
      ),
    );
  }
}
