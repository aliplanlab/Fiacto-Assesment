import 'package:common/common.dart';
import 'package:flutter/material.dart';

class RichTextWidgets extends StatelessWidget {
  const RichTextWidgets({
    super.key,
    required this.simpleTitle,
    this.style,
    required this.colorTitle,
    required this.onTap,
    this.colorTextStyle,
  });
  final String simpleTitle;
  final String colorTitle;
  final void Function(BuildContext context) onTap;
  final TextStyle? style;
  final TextStyle? colorTextStyle;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      pressedOpacity: 0.4,
      onTap: () => onTap(context),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: simpleTitle, style: style ?? context.sixteen400),
            TextSpan(
              text: colorTitle,
              style:
                  colorTextStyle ??
                  context.sixteen400.withColor(context.primary500),
            ),
          ],
        ),
      ),
    );
  }
}
