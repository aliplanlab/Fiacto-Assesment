import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.image,
    this.imageProvider,
    this.seed,
    this.size = 40,
    this.preview = false,
  });

  const CustomAvatar.preview({
    super.key,
    this.image,
    this.imageProvider,
    this.seed,
    this.size = 40,
  }) : preview = true;

  final String? image;
  final ImageProvider? imageProvider;
  final String? seed;
  final double size;
  final bool preview;

  @override
  Widget build(BuildContext context) {
    final color = seed?.notBlank?.color ?? context.grey900;
    return CustomInkWell(
      borderRadius: size,
      color: color,
      size: size,
      pressedOpacity: 0.7,
      onTap: preview ? () => _previewImage(context) : null,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (seed?.notBlank != null)
            Center(
              child: Text(
                seed!.takeInitials(2),
                style: context.sixteen700.withCustomFont(
                  color: color.contrast,
                  fontSize: size * 0.43,
                ),
              ),
            )
          else
            Center(
              child: Icon(
                CupertinoIcons.person_fill,
                color: color.contrast,
                size: size * 0.6,
              ),
            ),
          if (imageProvider != null)
            CustomImage(imageProvider!)
          else if (image?.notBlank != null)
            CustomNetworkImage(image),
        ],
      ),
    );
  }

  void _previewImage(BuildContext context) {
    if (image?.notBlank == null && imageProvider == null) return;
    showDialog<void>(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Center(
              child: imageProvider != null
                  ? CustomImage(imageProvider!)
                  : CustomNetworkImage(image),
            ),
            const Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CustomCloseButton(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomHorizontalSize extends StatelessWidget {
  const CustomHorizontalSize({
    super.key,
    required this.child,
    this.value = 0.7,
    this.alignment = AlignmentDirectional.center,
  });

  final Widget child;
  final double value;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: SizedBox(
        width: context.screenWidth * value,
        child: Align(
          alignment: alignment,
          child: child,
        ),
      ),
    );
  }
}
