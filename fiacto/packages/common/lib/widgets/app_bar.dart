import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.customTitle,
    this.leading,
    this.bottom,
    this.actions,
    this.leadingWidth,
    this.backgroundColor = Colors.transparent,
    this.foregroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.toolbarHeight,
    this.bottomHeight,
    this.actionSpacing = 16,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.showLeading = true,
    this.centerTitle = true,
  });

  const CustomAppBar.transparent({
    super.key,
    this.title,
    this.customTitle,
    this.leading,
    this.bottom,
    this.actions,
    this.leadingWidth,
    this.foregroundColor,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.toolbarHeight,
    this.bottomHeight,
    this.actionSpacing = 16,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.showLeading = true,
    this.centerTitle,
  }) : backgroundColor = Colors.transparent;

  factory CustomAppBar.noBar({
    SystemUiOverlayStyle? systemOverlayStyle,
  }) =>
      CustomAppBar(
        systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
        toolbarHeight: 0,
      );

  final String? title;
  final Widget? customTitle;
  final Widget? leading;
  final Widget? bottom;
  final List<Widget>? actions;
  final double? leadingWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final double? toolbarHeight;
  final double? bottomHeight;
  final double actionSpacing;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool showLeading;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: customTitle ?? (title != null ? Text(title!) : null),
      leading:
          implyLeading(context) ? leading ?? const CustomBackButton() : null,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(_bottomHeight),
              child: bottom!,
            )
          : null,
      actions: actions?.isNotEmpty == true
          ? actionSpacing > 0
              ? actions!
                  .expand((e) => [e, SizedBox(width: actionSpacing)])
                  .toList()
              : actions
          : null,
      leadingWidth: leadingWidth,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      toolbarHeight: _toolbarHeight,
      titleTextStyle: titleTextStyle ?? context.sixteen500,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: showLeading,
      centerTitle: centerTitle,
    );
  }

  double? get _titleHeight =>
      $cast<PreferredSizeWidget>(customTitle)?.preferredSize.height;

  double get _bottomHeight =>
      bottomHeight ??
      $cast<PreferredSizeWidget>(bottom)?.preferredSize.height ??
      0;

  double get _toolbarHeight =>
      toolbarHeight ?? _titleHeight ?? kDefaultToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(_toolbarHeight + _bottomHeight);

  bool implyLeading(BuildContext context) =>
      showLeading && (ModalRoute.of(context)?.impliesAppBarDismissal == true);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _PopButton(
      icon: AssetIcons.arrow_left,
      tooltio: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: onPressed,
    );
  }
}

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return _PopButton(
      icon: AssetIcons.cross_mark,
      tooltio: MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed: onPressed,
    );
  }
}

class _PopButton extends StatelessWidget {
  const _PopButton({
    required this.icon,
    this.tooltio,
    this.onPressed,
  });

  final AssetIcons icon;
  final String? tooltio;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: CustomIconButton.floating(
        backgroundColor: context.white,
        tooltip: tooltio,
        onPressed: onPressed ??
            () => context
              ..unfocus()
              ..pop(),
        color: context.grey900,
        icon: AssetIcon.monotone(
          icon,
          size: 32,
        ),
      ),
    );
  }
}

class CustomApplyButton extends StatelessWidget {
  const CustomApplyButton({
    super.key,
    this.enabled = true,
    this.onPressed,
  });

  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      enabled: enabled,
      borderRadius: 12,
      text: 'Apply',
      onPressed: onPressed ??
          () => context
            ..unfocus()
            ..pop(),
    );
  }
}

class CustomCancelButton extends StatelessWidget {
  const CustomCancelButton({
    super.key,
    this.enabled = true,
    this.onPressed,
  });

  final bool enabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      enabled: enabled,
      borderRadius: 12,
      text: 'Cancel',
      onPressed: onPressed ??
          () => context
            ..unfocus()
            ..pop(),
    );
  }
}

class CustomTitleBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTitleBar({
    super.key,
    this.title,
    this.subtitle,
    this.actions,
    this.bottom,
    this.bottomHeight,
    this.height = 60,
    this.padding = const EdgeInsets.only(top: 16, bottom: 10),
  });

  final Widget? title;
  final Widget? subtitle;
  final List<Widget>? actions;
  final Widget? bottom;
  final double? bottomHeight;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Size get preferredSize => Size.fromHeight(
        height +
            padding.vertical +
            (bottomHeight ??
                $cast<PreferredSizeWidget>(bottom)?.preferredSize.height ??
                0),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) title!,
                    if (title != null && subtitle != null)
                      const SizedBox(height: 8),
                    if (subtitle != null) subtitle!,
                  ],
                ),
              ),
              ...?actions,
            ],
          ),
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}

class CustomTitleMedium extends StatelessWidget {
  const CustomTitleMedium({
    super.key,
    this.text,
    this.children,
    this.padding,
  });

  final String? text;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: DefaultTextStyle(
        style: context.twenty700 ?? const TextStyle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text != null)
              Flexible(
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ...?children,
          ],
        ),
      ),
    );
  }
}

class CustomTitleLarge extends StatelessWidget {
  const CustomTitleLarge({
    super.key,
    this.text,
    this.children,
    this.padding,
  });

  final String? text;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: DefaultTextStyle(
        style: context.thiryTwo700 ?? const TextStyle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text != null)
              Flexible(
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ...?children,
          ],
        ),
      ),
    );
  }
}

class CustomTitleBottom extends StatelessWidget implements PreferredSizeWidget {
  const CustomTitleBottom({
    super.key,
    this.child,
    this.height = 32,
  });

  final Widget? child;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: Row(
          children: [if (child != null) child!],
        ),
      ),
    );
  }
}

class CustomSubtitle extends StatelessWidget {
  const CustomSubtitle({
    super.key,
    this.text,
    this.style,
    this.children,
    this.padding,
  });

  final String? text;
  final TextStyle? style;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: DefaultTextStyle(
        style: style ?? context.sixteen700.hint(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text != null)
              Flexible(
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ...?children,
          ],
        ),
      ),
    );
  }
}
