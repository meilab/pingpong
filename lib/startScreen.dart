import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  final bool isShow;
  const StartScreen({this.isShow = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isShow
        ? Container(
            alignment: Alignment(0, -0.2),
            child: Container(
                child: Text(
              "点击开始游戏",
              style: TextStyle(fontSize: 32, color: Colors.grey),
            )))
        : Container();
  }
}
