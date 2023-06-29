import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;

class Pointer extends StatelessWidget {
  final BoxConstraints constraints;
  const Pointer({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    double width = constraints.maxWidth;
    double svgSize = width / 1.55;
    double pointerSize = svgSize * 0.9;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translate(-width / 2, -width - svgSize * 0.32, 0.0),
      child: SizedBox(
        width: width,
        height: width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.translate(
              offset: const Offset(0, 4),
              child: ImageFiltered(
                imageFilter: ui.ImageFilter.blur(
                    sigmaY: 1, sigmaX: 1, tileMode: TileMode.decal),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(
                          0xFFC8881E,
                        ),
                        BlendMode.srcATop),
                    child: SizedBox(
                      width: pointerSize,
                      height: pointerSize,
                      child: SvgPicture.asset('lib/assets/pointer.svg'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
                width: pointerSize,
                height: pointerSize,
                child: SvgPicture.asset('lib/assets/pointer.svg')),
          ],
        ),
      ),
    );
  }
}
