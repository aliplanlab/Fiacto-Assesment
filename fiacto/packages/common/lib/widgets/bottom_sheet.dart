import 'package:common/common.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    this.showDragHandle = true,
    this.dragHandle = const CustomDragHandle(),
    this.title,
    this.customTitle,
    this.header,
    this.content,
    this.loading = false,
    this.canApply = true,
    this.onDone,
    this.shape,
    this.mainAxisSize,
    this.isExpanded = false,
  });
  final bool showDragHandle;
  final Widget dragHandle;
  final String? title;
  final Widget? customTitle;
  final Widget? header;
  final Widget? content;
  final bool loading;
  final bool canApply;
  final ShapeBorder? shape;
  final VoidCallback? onDone;
  final MainAxisSize? mainAxisSize;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: shape is RoundedRectangleBorder
          ? const BorderRadius.vertical(
              top: Radius.circular(8.0),
            )
          : BorderRadius.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        children: [
          if (showDragHandle) dragHandle,
          if (title != null)
            CustomHeader(
              title: title,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            ),
          if (customTitle != null) customTitle!,
          if (loading)
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: CustomProgress.large(),
            )
          else ...[
            if (header != null) header!,
            if (content != null)
              isExpanded ? Expanded(child: content!) : content!,
          ],
        ],
      ),
    );
  }
}

class CustomDragHandle extends StatelessWidget {
  const CustomDragHandle({
    super.key,
    this.color,
    this.size,
  });
  final Color? color;
  final Size? size;
  @override
  Widget build(BuildContext context) {
    final BottomSheetThemeData bottomSheetTheme =
        Theme.of(context).bottomSheetTheme;
    final Size handleSize =
        size ?? bottomSheetTheme.dragHandleSize ?? const Size(44, 5);
    final handleColor = color ??
        bottomSheetTheme.dragHandleColor ??
        Theme.of(context).colorScheme.outline;
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 24),
      width: double.infinity,
      child: Center(
        child: Container(
          height: handleSize.height,
          width: handleSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(handleSize.height / 2),
            color: handleColor,
          ),
        ),
      ),
    );
  }
}
