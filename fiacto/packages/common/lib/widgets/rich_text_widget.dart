import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.title,
    required this.colorTitle,
    this.onTap,
    this.subtitle,
    this.colorSubtitle,
    this.titleStyle,
    this.colorTitleStyle,
    this.subtitleStyle,
    this.colorSubtitleStyle,
  });
  final String title;
  final String colorTitle;
  final String? subtitle;
  final String? colorSubtitle;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? colorTitleStyle;
  final TextStyle? subtitleStyle;
  final TextStyle? colorSubtitleStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: titleStyle,
            ),
            TextSpan(
              text: colorTitle,
              style: colorTitleStyle,
            ),
            TextSpan(
              text: subtitle,
              style: subtitleStyle,
            ),
            TextSpan(
              text: colorSubtitle,
              style: colorSubtitleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
