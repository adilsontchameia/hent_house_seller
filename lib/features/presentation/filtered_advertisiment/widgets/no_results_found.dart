import 'package:flutter/material.dart';

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            'assets/not_found.jpg',
            height: 120.0,
            width: width,
            fit: BoxFit.cover,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
