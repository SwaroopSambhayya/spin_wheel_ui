import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spin_wheel/const.dart';
import 'package:spin_wheel/spinWheel/components/prize_content.dart';

class SuccessDialog extends StatefulWidget {
  final PrizeContent prizeContent;
  const SuccessDialog({super.key, required this.prizeContent});

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  late ConfettiController _controller;

  @override
  void initState() {
    _controller = ConfettiController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Currency curr = widget.prizeContent.getCurrency();
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned(
                top: height / 2 - 50,
                left: 20,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0)
                        .copyWith(top: 30, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Congratulations! you won the 0.002 ${describeEnum(curr)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Okay",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height / 2 - width * 0.44,
                left: 0,
                right: 0,
                child: SizedBox(
                    width: width * 0.5,
                    height: width * 0.4,
                    child: widget.prizeContent),
              ),
              Positioned(
                top: height / 2 - width * 0.44,
                left: 0,
                right: 0,
                child: Shimmer.fromColors(
                  baseColor: Colors.transparent,
                  loop: 6,
                  highlightColor: Colors.white,
                  child: SizedBox(
                    width: width * 0.5,
                    height: width * 0.4,
                    child: widget.prizeContent,
                  ),
                ),
              ),
              Positioned(
                left: width / 2 - 20,
                right: 0,
                child: ConfettiWidget(
                  confettiController: _controller,
                  blastDirectionality: BlastDirectionality.explosive,
                  blastDirection: pi / 2,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
