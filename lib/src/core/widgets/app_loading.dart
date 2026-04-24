import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/app_decorations.dart';
import '../extensions/context_ext.dart';

/// Represents the app loading indicator entity/model.
class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.isLinear = false, this.color});

  final bool isLinear;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (isLinear) {
      return Container(
        height: 4,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: context.colorsExt.dividerSubtle,
        ),
        child: LinearProgressIndicator(
          color: color ?? context.colors.primary,
          backgroundColor: Colors.transparent,
        ).animate(onPlay: (controller) => controller.repeat())
         .shimmer(duration: const Duration(seconds: 2)),
      );
    }

    return Center(
      child: CircularProgressIndicator(
        color: color ?? context.colors.primary,
        strokeWidth: 3,
      ),
    );
  }
}

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
    this.height = 120,
    this.width = double.infinity,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.white12 : Colors.black12;
    final highlightColor = isDark ? Colors.white24 : Colors.black26;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadius.cardAll,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  const ShimmerList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 120,
    this.spacing = 16.0,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  });

  final int itemCount;
  final double itemHeight;
  final double spacing;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      separatorBuilder: (_, _) => SizedBox(height: spacing),
      itemBuilder: (_, _) => ShimmerCard(height: itemHeight),
    );
  }
}
