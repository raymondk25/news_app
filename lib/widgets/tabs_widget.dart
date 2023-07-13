import 'package:flutter/material.dart';

class TabsWidget extends StatelessWidget {
  const TabsWidget(
      {super.key, required this.text, required this.color, required this.function, required this.fontSize});

  final String text;
  final Color color;
  final Function function;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
