import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomTitleSubtitle extends StatelessWidget {
  const CustomTitleSubtitle({
    super.key,
    required this.title,
    this.subtitle,
    this.isSubtitle = true,
    this.titleStyle,
    this.subtitleStyle,
    this.isIcon = false,
    this.height,
  });
  final String title;
  final String? subtitle;
  final bool isSubtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final bool isIcon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isIcon)
          Row(
            children: [
              Text(
                title,
                style: titleStyle ?? context.twenty600,
              ),
              const SizedBox(
                width: 8,
              ),
              const AssetIcon.multicolor(
                AssetIcons.verified_circle,
                size: 16,
              ),
            ],
          )
        else
          Text(
            title,
            style: titleStyle ?? context.twenty600,
          ),
        SizedBox(
          height: height ?? 8,
        ),
        if (isSubtitle)
          Text(
            subtitle ?? '',
            style: subtitleStyle ?? context.sixteen400,
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }
}
