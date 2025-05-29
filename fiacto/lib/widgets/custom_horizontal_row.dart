import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomHorizontalRow extends StatelessWidget {
  const CustomHorizontalRow({
    super.key,
    this.title,
    this.suffix,
    this.titleStyle,
    this.suffixTitleStyle,
  });
  final Widget? title;
  final Widget? suffix;
  final TextStyle? titleStyle;
  final TextStyle? suffixTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title ??
            Text(
              'Title',
              style: titleStyle ?? context.sixteen500.withColor(Colors.black),
            ),
        Spacer(),
        suffix ??
            Text(
              'Suffix',
              style:
                  suffixTitleStyle ??
                  context.sixteen500.withColor(context.primary700),
            ),
      ],
    );
  }
}
