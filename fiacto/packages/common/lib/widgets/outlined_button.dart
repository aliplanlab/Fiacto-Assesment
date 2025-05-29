import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.leading,
    this.trailing,
    this.height,
    this.width,
    this.borderRadius = 10.0,
    this.backgroundColor,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.foregroundColor,
    this.borderColor,
    this.isSpacer = false,
    this.textStyle,
  });

  const CustomOutlinedButton.expanded({
    super.key,
    required this.text,
    this.leading,
    this.trailing,
    this.height,
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.foregroundColor,
    this.borderColor,
    this.isSpacer = false,
    this.textStyle,
  }) : width = double.infinity;

  const CustomOutlinedButton.custom({
    super.key,
    required this.text,
    this.height,
    this.leading,
    this.trailing,
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.isSpacer = false,
    this.textStyle,
  })  : width = double.infinity,
        foregroundColor = const Color(0xFF4DAF50),
        borderColor = const Color(0xFF4DAF50);

  final String text;
  final TextStyle? textStyle;
  final Widget? leading;
  final Widget? trailing;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool loading;
  final bool isSpacer;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: loading
            ? () {}
            : enabled
                ? onPressed
                : null,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: BorderSide(
            color: borderColor ?? context.grey300,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: textStyle ?? context.sixteen500,
          disabledBackgroundColor: context.white,
          disabledForegroundColor: context.grey300,
        ),
        child: Row(
          children: [
            if (isSpacer) const Spacer() else const SizedBox.shrink(),
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 8.0),
            ],
            if (isSpacer)
              const SizedBox(
                width: 4,
              )
            else
              const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: loading
                  ? CustomProgress.small(color: context.primary500)
                  : Text(
                      text,
                      style: context.sixteen500.withColor(foregroundColor),
                    ),
            ),
            const Spacer(),
            if (trailing != null) ...[
              const SizedBox(width: 8.0),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}

class OutlinedButtonCustom extends StatelessWidget {
  const OutlinedButtonCustom({
    super.key,
    required this.text,
    this.leading,
    this.trailing,
    this.height,
    this.width,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.foregroundColor,
    this.borderColor,
    this.isSpacer = false,
    this.textStyle,
    this.buttonTextStyle,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
  });

  const OutlinedButtonCustom.expanded({
    super.key,
    required this.text,
    this.leading,
    this.trailing,
    this.height,
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.borderColor,
    this.isSpacer = false,
    this.textStyle,
    this.buttonTextStyle,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
  })  : width = double.infinity,
        foregroundColor = const Color(0xFF4DAF50);

  const OutlinedButtonCustom.custom({
    super.key,
    required this.text,
    this.height,
    this.leading,
    this.trailing,
    this.borderRadius = 8.0,
    this.backgroundColor = Colors.transparent,
    this.padding,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.isSpacer = false,
    this.textStyle,
    this.buttonTextStyle,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
  })  : width = double.infinity,
        foregroundColor = const Color(0xFF4DAF50),
        borderColor = const Color(0xFF4DAF50);

  final String text;
  final TextStyle? textStyle;
  final Widget? leading;
  final Widget? trailing;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool enabled;
  final bool loading;
  final bool isSpacer;
  final VoidCallback? onPressed;
  final TextStyle? buttonTextStyle;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: loading
            ? () {}
            : enabled
                ? onPressed
                : null,
        style: OutlinedButton.styleFrom(
          elevation: 0,
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: BorderSide(
            color: borderColor ?? context.primary500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: textStyle ?? context.sixteen500,
          disabledBackgroundColor: disabledBackgroundColor ?? context.grey300,
          disabledForegroundColor: disabledForegroundColor ?? context.white,
        ),
        child: Row(
          children: [
            if (isSpacer) const Spacer() else const SizedBox.shrink(),
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 8.0),
            ],
            if (isSpacer)
              const SizedBox(
                width: 4,
              )
            else
              const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: loading
                  ? CustomProgress.small(color: context.primary500)
                  : Text(
                      text,
                    ),
            ),
            const Spacer(),
            if (trailing != null) ...[
              const SizedBox(width: 8.0),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
