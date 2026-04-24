import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/app_durations.dart';

class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final Duration? delay;
  final Offset begin;
  final Duration? duration;
  final Curve? curve;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay,
    this.begin = const Offset(0, 0.2),
    this.duration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fade(
          duration: duration ?? AppDurations.normal,
          curve: curve ?? AppDurations.defaultCurve,
        )
        .slide(
          begin: begin,
          duration: duration ?? AppDurations.normal,
          curve: curve ?? AppDurations.defaultCurve,
        );
  }
}

class ScaleIn extends StatelessWidget {
  final Widget child;
  final Duration? delay;
  final Duration? duration;
  final Curve? curve;
  final double begin;

  const ScaleIn({
    super.key,
    required this.child,
    this.delay,
    this.duration,
    this.curve,
    this.begin = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fade(
          duration: duration ?? AppDurations.normal,
          curve: curve ?? AppDurations.defaultCurve,
        )
        .scale(
          begin: Offset(begin, begin),
          duration: duration ?? AppDurations.normal,
          curve: curve ?? AppDurations.defaultCurve,
        );
  }
}

class StaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration? delay;
  final Duration? stagger;

  const StaggeredList({
    super.key,
    required this.children,
    this.delay,
    this.stagger,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .animate(
            delay: delay,
            interval: stagger ?? AppDurations.stagger,
          )
          .fade(
            duration: AppDurations.normal,
            curve: AppDurations.defaultCurve,
          )
          .slide(
            begin: const Offset(0, 0.2),
            duration: AppDurations.normal,
            curve: AppDurations.defaultCurve,
          ),
    );
  }
}
