import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pingpong/ball.dart';
import 'package:pingpong/rocket.dart';
import 'package:pingpong/startScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

const double rocketStep = 0.1;
const double ballStep = 0.01;
const double maxY = 0.95;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Direction {
  Up,
  Down,
  Left,
  Right,
}

class _MyHomePageState extends State<MyHomePage> {
  double ballX = 0;
  double ballY = 0;
  double upX = 0;
  double downX = 0;
  bool isRunning = false;
  Direction vDirection = Direction.Down;
  Direction hDirection = Direction.Right;
  late Timer timer;

  start() {
    setState(() {
      isRunning = true;
    });
    timer = Timer.periodic(Duration(milliseconds: 20), (timer) {
      double newBallY = ballY;
      double newBallX = ballX;
      Direction newVDirection = vDirection;
      Direction newHDirection = hDirection;

      switch (vDirection) {
        case Direction.Up:
          newBallY -= ballStep;
          break;
        case Direction.Down:
          newBallY += ballStep;
          break;
        default:
      }

      switch (hDirection) {
        case Direction.Left:
          newBallX -= ballStep * 2;
          break;
        case Direction.Right:
          newBallX += ballStep * 2;
          break;
        default:
      }

      final rocketLen = 2 / 3;

      if (newBallY <= -maxY) {
        if (newBallX < (upX - rocketLen / 2) ||
            newBallX > (upX + rocketLen / 2)) {
          setState(() {
            isRunning = false;
          });

          timer.cancel();
        }
        newVDirection = Direction.Down;
      } else if (newBallY >= maxY) {
        if (newBallX < (downX - rocketLen / 2) ||
            newBallX > (downX + rocketLen / 2)) {
          setState(() {
            isRunning = false;
          });
          timer.cancel();
        }
        newVDirection = Direction.Up;
      }

      if (newBallX <= -1) {
        newHDirection = Direction.Right;
      } else if (newBallX >= 1) {
        newHDirection = Direction.Left;
      }

      setState(() {
        ballY = newBallY;
        ballX = newBallX;
        vDirection = newVDirection;
        hDirection = newHDirection;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (event) {
            if (event.runtimeType == RawKeyDownEvent) {
              switch (event.logicalKey.keyLabel) {
                case "Arrow Left":
                  setState(() {
                    upX = upX - rocketStep;
                    downX = downX - rocketStep;
                  });
                  break;
                case "Arrow Right":
                  setState(() {
                    upX = upX + rocketStep;
                    downX = downX + rocketStep;
                  });
                  break;
                default:
              }
            }
          },
          child: GestureDetector(
            onTap: () {
              start();
            },
            child: Stack(
              children: [
                StartScreen(
                  isShow: !isRunning,
                ),
                Rocket(x: upX, y: -maxY, color: Colors.red),
                Ball(x: ballX, y: ballY),
                Rocket(x: downX, y: maxY, color: Colors.black),
              ],
            ),
          ),
        ));
  }
}
