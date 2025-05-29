import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetIcon extends StatelessWidget {
  const AssetIcon.monotone(
    this.icon, {
    this.size,
    this.color,
    super.key,
  }) : type = AssetIconType.monotone;

  const AssetIcon.multicolor(
    this.icon, {
    this.size,
    super.key,
  })  : type = AssetIconType.multicolor,
        color = null;

  final AssetIcons icon;
  final double? size;
  final Color? color;
  final AssetIconType type;

  @override
  Widget build(BuildContext context) {
    if (icon == AssetIcons.blank) return const SizedBox.shrink();
    return _AssetIconVector(
      icon,
      type: type,
      size: size,
      color: color,
    );
  }
}

class _AssetIconVector extends StatelessWidget {
  const _AssetIconVector(
    this.icon, {
    required this.type,
    this.size,
    this.color,
  });

  final AssetIcons icon;
  final double? size;
  final Color? color;
  final AssetIconType type;

  @override
  Widget build(BuildContext context) {
    final iconTheme = IconTheme.of(context);
    return SvgPicture.asset(
      icon.asset(type),
      width: size ?? iconTheme.size,
      height: size ?? iconTheme.size,
      colorFilter: type == AssetIconType.multicolor
          ? null
          : ColorFilter.mode(
              color ?? iconTheme.color ?? context.primary500,
              BlendMode.srcIn,
            ),
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
  }) : darkLevel = null;

  const CustomNetworkImage.dark(
    this.url, {
    super.key,
    this.fit = BoxFit.cover,
    this.darkLevel = 0.4,
  });

  final String? url;
  final BoxFit? fit;
  final double? darkLevel;

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      NetworkImage(url ?? ''),
      fit: fit,
      darkLevel: darkLevel,
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage(
    this.image, {
    super.key,
    this.fit = BoxFit.cover,
    this.darkLevel,
  });

  final ImageProvider image;
  final BoxFit? fit;
  final double? darkLevel;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
      frameBuilder: (_, child, frame, loaded) => Container(
        foregroundDecoration: darkLevel == null
            ? null
            : BoxDecoration(
                color: Colors.black.withOpacity(darkLevel!),
              ),
        child: child,
      ),
      loadingBuilder: (_, child, progress) =>
          progress?.cumulativeBytesLoaded == progress?.expectedTotalBytes
              ? child
              : const SizedBox.shrink(),
    );
  }
}

class CustomThumbnail extends StatelessWidget {
  const CustomThumbnail(
    this.url, {
    super.key,
    this.borderRadius = 8,
    this.width = 72,
    this.height = 56,
  }) : aspectRatio = false;

  const CustomThumbnail.aspectRatio(
    this.url, {
    super.key,
    this.borderRadius = 8,
    this.width = 72,
    this.height = 56,
  }) : aspectRatio = true;

  final String url;
  final bool aspectRatio;
  final double borderRadius;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return aspectRatio
        ? CustomInkWell(
            borderRadius: borderRadius,
            child: AspectRatio(
              aspectRatio: width / height,
              child: _child,
            ),
          )
        : CustomInkWell(
            borderRadius: borderRadius,
            width: width,
            height: height,
            child: _child,
          );
  }

  Widget get _child => CustomNetworkImage(url);
}
