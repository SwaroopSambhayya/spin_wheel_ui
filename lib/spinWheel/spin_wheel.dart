import 'dart:math';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spin_wheel/const.dart';
import 'package:spin_wheel/spinWheel/components/pointer.dart';
import 'package:spin_wheel/spinWheel/components/spin_button.dart';
import 'package:spin_wheel/spinWheel/components/spin_item_tile.dart';
import 'package:spin_wheel/spinWheel/components/success_dialog.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AudioPlayer player1;
  late AudioPlayer player2;
  late AudioPlayer player3;
  Tween<double> animation = Tween(
    begin: 0,
    end: 1 * (pi / 3),
  );
  int numberOfChoices = 6;
  int? finalChoice;
  bool spinButtonEnabled = true;
  @override
  void initState() {
    super.initState();
    initResources();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addStatusListener((status) async {
        if (status == AnimationStatus.forward) {
          setState(() {
            spinButtonEnabled = false;
          });
        }
        if (status == AnimationStatus.completed) {
          showDialog(
            context: context,
            builder: (context) => SuccessDialog(
              prizeContent: prizes[finalChoice!],
            ),
          );
          await player3.play();
          player3.seek(Duration.zero, index: 0);
          player3.stop();
          setState(() {
            spinButtonEnabled = true;
          });
        }
      });
    });
  }

  initResources() async {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    player1 = AudioPlayer();
    player2 = AudioPlayer();
    player3 = AudioPlayer();
    await player3.setAsset('lib/assets/musics/success-1-6297.mp3');
  }

  void spin() async {
    List<double> positions = [
      pi / 3,
      2 * pi / 3,
      pi,
      4 * pi / 3,
      5 * pi / 3,
      2 * pi
    ];
    try {
      await player1.setAsset(
          'lib/assets/musics/cash-register-purchase-87313.mp3',
          preload: true);
      await player2.setAsset('lib/assets/musics/spin_wheel.mp3', preload: true);
      player1.play();
      player2.play();
    } catch (e) {
      print(e);
    }
    finalChoice = Random().nextInt(6);
    double rotateByValue = (pi - (positions[finalChoice!])) + 16 * pi;
    print(finalChoice);
    animation.end = rotateByValue;

    _controller
      ..reset()
      ..forward()
      ..fling(
        velocity: 0.5,
        animationBehavior: AnimationBehavior.normal,
        springDescription:
            const SpringDescription(mass: 1, stiffness: 1, damping: 2.5),
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    player1.dispose();
    player2.dispose();
    player3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = MediaQuery.of(context).size.width / 2;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        for (int i = 1; i <= numberOfChoices; i++)
          Positioned(
            left: radius,
            top: screenHeight / 2,
            child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return SpinItemTile(
                    rotationAnimationValue:
                        animation.animate(_controller).value,
                    prizeContent: prizes[i - 1],
                    color: i % 2 == 0
                        ? const Color(0xff3f37c9)
                        : const Color(0xff4361ee),
                    constraints: BoxConstraints(maxWidth: radius),
                    choiceNumber: i,
                    totalChoices: numberOfChoices,
                  );
                }),
          ),
        Positioned(
          top: screenHeight / 2,
          left: radius,
          child: Pointer(
            constraints: BoxConstraints(maxWidth: radius),
          ),
        ),
        Positioned(
          top: screenHeight / 2,
          left: radius,
          child: SpinButton(
            onSpin: spinButtonEnabled ? spin : null,
            constraints: BoxConstraints(maxWidth: radius),
          ),
        )
      ],
    );
  }
}
