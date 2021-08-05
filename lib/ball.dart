import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double x;
  final double y;
  const Ball({required this.x, required this.y, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
      ),
    );
  }
}
