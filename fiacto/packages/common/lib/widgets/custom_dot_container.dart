import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomDotContainer extends StatelessWidget {
  const CustomDotContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 8,
      backgroundColor: context.grey50,
      child: Container(
        height: 10,
        width: 6,
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color: context.success500,
        ),
      ),
    );
  }
}
