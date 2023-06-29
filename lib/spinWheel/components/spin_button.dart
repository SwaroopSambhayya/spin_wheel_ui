import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SpinButton extends StatefulWidget {
  final void Function()? onSpin;
  final BoxConstraints constraints;
  const SpinButton({super.key, this.onSpin, required this.constraints});

  @override
  State<SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<SpinButton> {
  double buttonTop = 2;
  bool glowEnabled = true;
  void setTimer() {
    Timer(const Duration(milliseconds: 150), () {
      setState(() {
        buttonTop = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = widget.constraints.maxWidth;
    double svgSize = width / 1.55;
    double buttonsSize = svgSize * 0.7;
    return Transform(
      transform: Matrix4.identity()..translate(-width / 2, -width, 0.0),
      alignment: Alignment.center,
      child: SizedBox(
        height: width,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: width / 4 + 8,
              child: Container(
                width: buttonsSize,
                height: buttonsSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(
                    0xFFC8881E,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: width / 4 + buttonTop,
              duration: const Duration(milliseconds: 150),
              child: GestureDetector(
                onTap: widget.onSpin != null
                    ? () {
                        setState(() {
                          glowEnabled = false;
                          buttonTop = 8;
                        });
                        widget.onSpin!();
                        setTimer();
                      }
                    : null,
                child: Container(
                  width: buttonsSize,
                  height: buttonsSize,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFE9AE70),
                            Color(0xffFBE2A4),
                          ],
                          tileMode: TileMode.clamp,
                          stops: [0.25, 1])),
                  child: Center(
                    child: Shimmer.fromColors(
                      enabled: glowEnabled,
                      baseColor: const Color(0xFFC8881E),
                      highlightColor: !glowEnabled
                          ? const Color(0xFFC8881E)
                          : const Color(0xffFBE2A4),
                      child: const Text(
                        'SPIN',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
