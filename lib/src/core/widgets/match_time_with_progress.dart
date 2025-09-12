import 'package:flutter/material.dart';
import 'package:live_score/src/core/utils/app_colors.dart';

class MatchTimeWithProgress extends StatefulWidget {
  final String time;
  final Color mainColor;
  final int widthFactor;

  const MatchTimeWithProgress({
    super.key,
    required this.time,
    this.mainColor = AppColors.red,
    this.widthFactor = 2,
  });

  @override
  State<MatchTimeWithProgress> createState() => _MatchTimeWithProgressState();
}

class _MatchTimeWithProgressState extends State<MatchTimeWithProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.widthFactor - 1),
    )..repeat(reverse: true); // fill → empty → fill
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.time.isNotEmpty ? widget.time : 'LIVE',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: widget.mainColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _controller.value / widget.widthFactor,
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  color: widget.mainColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
