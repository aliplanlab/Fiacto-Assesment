import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHorizontalListView extends StatelessWidget {
  const CustomHorizontalListView({
    super.key,
    required this.itemBuilder,
    this.itemCount = 0,
    this.section,
    this.divider,
    this.edgeDivider = const SizedBox(width: 8),
    this.height = 180,
    this.shrinkWrap = false,
    this.clipBehavior = Clip.hardEdge,
  });

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Widget? section;
  final Widget? divider;
  final Widget? edgeDivider;
  final double height;
  final bool shrinkWrap;
  final Clip clipBehavior;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section != null) section!,
        SizedBox(
          height: height,
          child: ListView.separated(
            clipBehavior: clipBehavior,
            shrinkWrap: shrinkWrap,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            separatorBuilder: (context, index) =>
                divider ?? const SizedBox.shrink(),
            itemBuilder: (context, index) {
              return edgeDivider != null
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (index == 0) edgeDivider!,
                        itemBuilder(context, index),
                        if (index == itemCount - 1) edgeDivider!,
                      ],
                    )
                  : itemBuilder(context, index);
            },
          ),
        ),
      ],
    );
  }
}

class AlwaysBouncingScrollPhysics extends AlwaysScrollableScrollPhysics {
  const AlwaysBouncingScrollPhysics({super.parent});

  @override
  AlwaysBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return AlwaysBouncingScrollPhysics(
      parent: BouncingScrollPhysics(parent: buildParent(ancestor)),
    );
  }
}

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.headerBuilder,
    this.footerBuilder,
    required this.itemBuilder,
    this.itemCount = 0,
    this.section,
    this.divider,
    this.reverse = false,
    this.shrinkWrap = false,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  final ScrollController? controller;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final WidgetBuilder? headerBuilder;
  final WidgetBuilder? footerBuilder;
  final NullableIndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Widget? section;
  final Widget? divider;
  final bool reverse;
  final bool shrinkWrap;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      scrollDirection: scrollDirection,
      physics: physics,
      reverse: reverse,
      shrinkWrap: shrinkWrap,
      keyboardDismissBehavior: keyboardDismissBehavior,
      itemCount: itemCount + 2,
      separatorBuilder: (context, index) {
        if (index == 0) {
          return section ?? const SizedBox.shrink();
        }

        return divider ?? const SizedBox.shrink();
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return headerBuilder?.call(context) ?? const SizedBox.shrink();
        } else if (index == itemCount + 1) {
          return footerBuilder?.call(context) ?? const SizedBox.shrink();
        }

        return itemBuilder(context, index - 1);
      },
    );
  }
}

class CustomSection extends StatelessWidget {
  const CustomSection.h1({
    super.key,
    required this.text,
    this.topPadding = 16,
    this.bottomPadding = 16,
    this.verticalPadding,
    this.startPadding = 16,
    this.endPadding = 16,
    this.horizontalPadding,
    this.leading,
    this.trailing,
  }); // : headingStyle = HeadingStyle.h1;

  const CustomSection.h2({
    super.key,
    required this.text,
    this.topPadding = 16,
    this.bottomPadding = 16,
    this.verticalPadding,
    this.startPadding = 16,
    this.endPadding = 16,
    this.horizontalPadding,
    this.leading,
    this.trailing,
  }); // : headingStyle = HeadingStyle.h2;

  const CustomSection.h3({
    super.key,
    required this.text,
    this.topPadding = 16,
    this.bottomPadding = 16,
    this.verticalPadding,
    this.startPadding = 0,
    this.endPadding = 0,
    this.horizontalPadding,
    this.leading,
    this.trailing,
  }); // : headingStyle = HeadingStyle.h3;

  const CustomSection.h4({
    super.key,
    required this.text,
    this.topPadding = 16,
    this.bottomPadding = 16,
    this.verticalPadding,
    this.startPadding = 0,
    this.endPadding = 0,
    this.horizontalPadding,
    this.leading,
    this.trailing,
  }); // : headingStyle = HeadingStyle.h4;

  final String text;
  //final HeadingStyle headingStyle;
  final double topPadding;
  final double bottomPadding;
  final double? verticalPadding;
  final double startPadding;
  final double endPadding;
  final double? horizontalPadding;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        horizontalPadding ?? startPadding,
        verticalPadding ?? topPadding,
        horizontalPadding ?? endPadding,
        verticalPadding ?? bottomPadding,
      ),
      child: Row(
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: leading,
            ),
          Text(
            text,
            //style: headingStyle(context),
          ),
          const Spacer(),
          if (trailing != null)
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8),
              child: trailing,
            ),
        ],
      ),
    );
  }
}

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    this.title,
    this.subtitle,
    this.bottom,
    this.padding = const EdgeInsets.only(bottom: 12),
  });

  final String? title;
  final String? subtitle;
  final Widget? bottom;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: context.twenty700,
            ),
          if (title != null && subtitle != null) const SizedBox(height: 8),
          if (subtitle != null)
            Text(
              subtitle!,
              style: context.sixteen400,
            ),
          if (bottom != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: bottom,
            ),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.customTitle,
    this.subtitle,
    this.customSubtitle,
    this.leading,
    this.trailing,
    this.titleStyle,
    this.subtitleStyle,
    this.titleMaxLines,
    this.subtitleMaxLines,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.width,
    this.height,
  });

  final String? title;
  final Widget? customTitle;
  final String? subtitle;
  final Widget? customSubtitle;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final int? titleMaxLines;
  final int? subtitleMaxLines;
  final CrossAxisAlignment crossAxisAlignment;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(
            width: width ?? 16,
          ),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null || customTitle != null)
                DefaultTextStyle(
                  style: titleStyle ?? context.fourteen400,
                  maxLines: titleMaxLines,
                  overflow: titleMaxLines == 1
                      ? TextOverflow.ellipsis
                      : TextOverflow.clip,
                  child: customTitle ?? Text(title!),
                ),
              if (subtitle != null || customSubtitle != null)
                SizedBox(height: height ?? 0),
              DefaultTextStyle(
                style: subtitleStyle ?? context.fourteen400,
                maxLines: subtitleMaxLines,
                overflow: subtitleMaxLines == 1
                    ? TextOverflow.ellipsis
                    : TextOverflow.clip,
                child: customSubtitle ?? Text(subtitle ?? ''),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing!,
        ],
      ],
    );
  }
}

class CustomProgress extends StatelessWidget {
  const CustomProgress({
    super.key,
    required this.size,
    this.centered = true,
    this.color,
  });

  const CustomProgress.small({
    super.key,
    this.centered = true,
    this.color,
  }) : size = 18.0;

  const CustomProgress.medium({
    super.key,
    this.centered = true,
    this.color,
  }) : size = 34.0;

  const CustomProgress.large({
    super.key,
    this.centered = true,
    this.color,
  }) : size = 40.0;

  final double size;
  final bool centered;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: centered ? null : size,
      child: Center(
        child: SizedBox.square(
          dimension: size,
          child: context.platform == TargetPlatform.iOS
              ? CupertinoActivityIndicator(
                  radius: size / 2,
                  color: color,
                )
              : CircularProgressIndicator(
                  strokeWidth: size * 0.09,
                  color: color,
                ),
        ),
      ),
    );
  }
}

class CustomError extends StatelessWidget {
  const CustomError({
    super.key,
    this.message,
    this.emptyMessage,
    this.isFailure = false,
    this.centered = true,
    this.action,
    this.onRetry,
  });

  final String? message;
  final String? emptyMessage;
  final bool isFailure;
  final bool centered;
  final Widget? action;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: centered ? Alignment.center : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isFailure ? message ?? '' : emptyMessage ?? 'No data available',
            style:
                context.fourteen400.withColor(context.grey900.withOpacity(0.6)),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null && isFailure)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomInkWell(
                onTap: onRetry,
                borderRadius: 6,
                borderWidth: 1,
                borderColor: context.primary500,
                splashColor: context.primary500.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                child: Text(
                  'Retry',
                  style: context.fourteen400,
                ),
              ),
            ),
          if (action != null && !isFailure)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: action,
            ),
        ],
      ),
    );
  }
}
