import 'package:flutter/material.dart';
import 'package:spin_wheel/spinWheel/components/prize_content.dart';

List<PrizeContent> prizes = List.generate(
    6,
    (index) => PrizeContent(
        content: Image.asset(
          'lib/assets/prizes/${index + 1}.png',
          width: 50,
          height: 50,
        ),
        currency: Currency.values[index]));

// ignore: constant_identifier_names
enum Currency { ATLAS, ADA, LOOKS, BNB, SAND, UNI }
