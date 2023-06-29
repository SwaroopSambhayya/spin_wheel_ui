import 'package:flutter/material.dart';
import 'package:spin_wheel/const.dart';

class PrizeContent extends StatelessWidget {
  final Widget content;
  final Currency currency;
  const PrizeContent(
      {super.key, required this.content, required this.currency});

  Currency getCurrency() {
    return currency;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(tag: currency, child: content);
  }
}
