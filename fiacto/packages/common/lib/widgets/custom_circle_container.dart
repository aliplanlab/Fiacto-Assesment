import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomCircleContainer extends StatelessWidget {
  const CustomCircleContainer({
    super.key,
    required this.text,
    this.size = 30.0,
  });
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.primary500,
      ),
      child: Center(
        child: Text(
          text,
          style: context.twelve600.withColor(context.white),
        ),
      ),
    );
  }
}
