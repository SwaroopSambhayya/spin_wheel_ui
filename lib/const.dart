import 'package:flutter/material.dart';
import 'package:spin_wheel/spinWheel/components/prize_content.dart';

List<PrizeContent> prizes = List.generate(
    6,
    (index) => PrizeContent(
        content: Container(
          width: 40,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: LinearGradient(
                colors: index == 2
                    ? [
                        const Color(0xFFE9AE70),
                        const Color(0xffFBE2A4),
                      ]
                    : [Colors.white10, Colors.white10],
                tileMode: TileMode.clamp,
                stops: index == 2 ? const [0.25, 1] : [0.25, 1]),
          ),
          child: Center(
            child: Text(
              options[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: index == 2
                      ? const Color(
                          0xFFC8881E,
                        )
                      : Colors.white),
            ),
          ),
        ),
        option: options[index]));

// ignore: constant_identifier_names
List<String> options = ["2.5x", "1x", "5x", "3x", "4x", "2x"];
