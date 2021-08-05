import 'package:flutter/material.dart';

class Rocket extends StatelessWidget {
  final double x;
  final double y;
  final Color color;
  const Rocket(
      {required this.x, required this.y, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 20,
          color: color,
        ),
      ),
    );
  }
}
