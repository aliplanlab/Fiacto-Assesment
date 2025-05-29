import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    this.child,
    this.color,
    this.image,
    this.splashColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius = 0,
    this.outlineColor,
    this.outlineWidth,
    this.elevation,
    this.dropShadow,
    this.size,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.pressedOpacity,
    this.enabled = true,
    this.onTap,
  });

  const CustomInkWell.rounded({
    super.key,
    this.child,
    this.color,
    this.image,
    this.splashColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius = 10,
    this.outlineColor,
    this.outlineWidth,
    this.elevation,
    this.dropShadow,
    this.size,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.pressedOpacity,
    this.enabled = true,
    this.onTap,
  });

  final Widget? child;
  final Color? color;
  final ImageProvider? image;
  final Color? splashColor;
  final Color? borderColor;
  final double? borderWidth;
  final double borderRadius;
  final Color? outlineColor;
  final double? outlineWidth;
  final double? elevation;
  final double? dropShadow;
  final double? size;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  /// `0.4` is recommended for buttons and `0.6` for cards/images
  final double? pressedOpacity;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Material(
        type: color == null && outlineWidth == null
            ? MaterialType.transparency
            : MaterialType.canvas,
        color: outlineWidth != null ? outlineColor ?? context.outline : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius + (outlineWidth ?? 0)),
          ),
        ),
        child: SizedBox(
          child: Material(
            type:
                color == null ? MaterialType.transparency : MaterialType.canvas,
            color: color ?? Colors.transparent,
            clipBehavior: Clip.antiAlias,
            elevation: elevation ?? 0,
            shadowColor: context.shadow.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              side: borderWidth != null
                  ? BorderSide(
                      color: borderColor ?? context.outline,
                      width: borderWidth!,
                    )
                  : BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            child: onTap == null || !enabled
                ? _child
                : pressedOpacity != null
                    ? CupertinoButton(
                        onPressed: onTap,
                        pressedOpacity: pressedOpacity,
                        minSize: 0,
                        padding: EdgeInsets.zero,
                        child: _child,
                      )
                    : InkWell(
                        onTap: onTap,
                        splashColor: splashColor,
                        highlightColor: splashColor?.withOpacity(0.1),
                        child: _child,
                      ),
          ),
        ),
      ),
    );
  }

  Widget get _child => SizedBox(
        width: size ?? width,
        height: size ?? height,
        child: _image ??
            Container(
              padding: padding,
              child: child,
            ),
      );

  Widget? get _image => image != null
      ? Ink(
          padding: padding,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: image!,
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        )
      : null;
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor,
    this.outlineColor,
    this.size = 40,
    this.iconSize,
    this.dropShadow,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.outlineWidth,
    this.circle = false,
    this.enabled = true,
    this.padding,
    this.onPressed,
  })  : pressedOpacity = null,
        floating = false;

  const CustomIconButton.cupertino({
    super.key,
    required this.icon,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor,
    this.outlineColor,
    this.size = 40,
    this.iconSize,
    this.pressedOpacity = 0.4,
    this.dropShadow,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.outlineWidth,
    this.circle = false,
    this.enabled = true,
    this.padding,
    this.onPressed,
  }) : floating = false;

  const CustomIconButton.floating({
    super.key,
    required this.icon,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor,
    this.outlineColor,
    this.size = 40,
    this.iconSize,
    this.dropShadow = 8,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.outlineWidth,
    this.circle = true,
    this.enabled = true,
    this.padding,
    this.onPressed,
  })  : pressedOpacity = null,
        floating = true;

  const CustomIconButton.circle({
    super.key,
    required this.icon,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.backgroundImage,
    this.borderColor,
    this.outlineColor,
    this.size = 40,
    this.iconSize,
    this.dropShadow,
    this.elevation,
    this.borderWidth,
    this.borderRadius,
    this.outlineWidth,
    this.enabled = true,
    this.padding,
    this.onPressed,
  })  : pressedOpacity = null,
        floating = false,
        circle = true;

  final Widget icon;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final Color? borderColor;
  final Color? outlineColor;
  final double size;
  final double? iconSize;
  final double? pressedOpacity;
  final double? dropShadow;
  final double? elevation;
  final double? borderWidth;
  final double? borderRadius;
  final double? outlineWidth;
  final bool floating;
  final bool circle;
  final bool enabled;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: enabled ? onPressed : null,
      color: backgroundColor ?? (floating ? context.white : null),
      image: backgroundImage,
      dropShadow: dropShadow,
      elevation: elevation,
      borderColor: borderColor,
      borderWidth: borderWidth,
      outlineColor: outlineColor,
      outlineWidth: outlineWidth,
      pressedOpacity: pressedOpacity,
      padding: padding ?? EdgeInsets.zero,
      size: size,
      borderRadius: borderRadius ?? (circle ? size : 10),
      child: Center(
        child: IconTheme(
          data: context.theme.iconTheme.copyWith(
            size: iconSize,
            color: color,
          ),
          child: icon,
        ),
      ),
    ).tooltip(tooltip);
  }
}

extension TooltipWidget on Widget {
  Widget tooltip(
    String? message, {
    bool enabled = true,
    Key? key,
  }) =>
      enabled && message?.notBlank != null
          ? Tooltip(
              key: key,
              message: message,
              child: this,
            )
          : this;
}

class CustomSelectedButton extends StatelessWidget {
  const CustomSelectedButton({
    super.key,
    this.text,
    this.selectedText,
    this.selectedColor,
    this.loading = false,
    this.selected = false,
    this.enabled = true,
    this.onPressed,
  });

  final String? text;
  final String? selectedText;
  final Color? selectedColor;
  final bool loading;
  final bool selected;
  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: loading ? null : onPressed,
      borderWidth: selected ? null : 1,
      borderRadius: 24,
      color: selected ? selectedColor?.withOpacity(0.05) : null,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: loading
          ? const CustomProgress.small()
          : Text(
              (selected ? selectedText : text) ?? '',
              style: selected
                  ? context.fourteen400.withColor(selectedColor)
                  : context.fourteen400,
            ),
    );
  }
}
