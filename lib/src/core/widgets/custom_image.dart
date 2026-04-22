import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
    this.fit,
  });

  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 150),
      placeholder:
          (_, _) =>
              placeholder ??
              SizedBox(
                height: height,
                width: width,
                child: const DecoratedBox(
                  decoration: BoxDecoration(color: Colors.transparent),
                ),
              ),
      errorWidget: (_, _, _) {
        return errorWidget ?? const SizedBox.shrink();
      },
    );
  }
}
