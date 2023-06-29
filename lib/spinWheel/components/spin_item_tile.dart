import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spin_wheel/const.dart';
import 'package:spin_wheel/spinWheel/components/pointer.dart';

class SpinItemTile extends StatelessWidget {
  final BoxConstraints constraints;
  final int choiceNumber;
  final int totalChoices;
  final Widget prizeContent;
  final double rotationAnimationValue;
  final Color? color;
  const SpinItemTile(
      {super.key,
      required this.constraints,
      required this.choiceNumber,
      required this.totalChoices,
      required this.prizeContent,
      this.color,
      required this.rotationAnimationValue});

  @override
  Widget build(BuildContext context) {
    double width = constraints.maxWidth;
    double svgSize = width / 1.55;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate((-width / 2), -width, 0)
        ..rotateZ(2 * pi * choiceNumber / 6)
        ..rotateZ(rotationAnimationValue)
        ..translate(0.0, width / 2, 0.0)
        ..rotateZ(pi),
      child: SizedBox(
        width: width,
        height: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: const Offset(0, 2),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                    sigmaY: 1, sigmaX: 1, tileMode: TileMode.decal),
                child: Container(
                  width: svgSize,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.srcATop),
                    child: SvgPicture.asset('lib/assets/tile.svg'),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: svgSize,
              child: Center(
                  child: SvgPicture.asset('lib/assets/tile.svg',
                      colorFilter: ColorFilter.mode(
                          color ?? Colors.transparent, BlendMode.srcATop),
                      semanticsLabel: 'Acme Logo')),
            ),
            Positioned.fill(
              child: Center(
                child: prizeContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
