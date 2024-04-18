import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final String name;
  final Color color;
  final Icon icon;
  final double width;
  final double height;
  final void Function() onTap;
  const CircleWidget(
      {super.key,
      required this.name,
      required this.color,
      required this.icon,
      required this.width,
      required this.height,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Center(child: icon),
          ),
          Text(
            name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
