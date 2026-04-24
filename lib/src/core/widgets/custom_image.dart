import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_decorations.dart';

/// Represents the custom image entity/model.
class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
    this.fit,
    this.borderRadius,
    this.border,
    this.shadow,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl.toLowerCase().endsWith('.svg')) {
      imageWidget = SvgPicture.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        placeholderBuilder: (_) => placeholder ?? _buildShimmer(context),
      );
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 300),
        placeholder: (_, _) => placeholder ?? _buildShimmer(context),
        errorWidget: (_, _, _) => errorWidget ?? const SizedBox.shrink(),
      );
    }

    if (borderRadius != null || border != null || shadow != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: border,
          boxShadow: shadow != null ? [shadow!] : null,
        ),
        clipBehavior: borderRadius != null ? Clip.hardEdge : Clip.none,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildShimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.white12 : Colors.black12,
      highlightColor: isDark ? Colors.white24 : Colors.black26,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? AppBorderRadius.smallAll,
        ),
      ),
    );
  }
}
