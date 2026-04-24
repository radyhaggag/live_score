import 'package:flutter/material.dart';

class PitchPainter extends CustomPainter {
  final Color pitchColor;
  final Color lineColor;

  PitchPainter({
    this.pitchColor = const Color(0xFF1E5631), // Darker, richer green
    this.lineColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the pitch background
    final paint = Paint()
      ..color = pitchColor
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);

    // Draw alternating grass stripes for realism
    final stripePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;
    
    const int numStripes = 12;
    final double stripeHeight = size.height / numStripes;
    for (int i = 0; i < numStripes; i++) {
      if (i % 2 == 0) {
        canvas.drawRect(
          Rect.fromLTWH(0, i * stripeHeight, size.width, stripeHeight),
          stripePaint,
        );
      }
    }

    // Line drawing setup (higher opacity)
    final linePaint = Paint()
      ..color = lineColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw outer boundary
    canvas.drawRect(rect, linePaint);

    // Draw halfway line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      linePaint,
    );

    // Draw center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.15,
      linePaint,
    );

    // Draw center spot
    final spotPaint = Paint()
      ..color = lineColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 3, spotPaint);

    // Draw penalty areas
    final double penaltyAreaWidth = size.width * 0.55;
    final double penaltyAreaHeight = size.height * 0.14;
    final double penaltyAreaLeft = (size.width - penaltyAreaWidth) / 2;

    // Top penalty area
    canvas.drawRect(
      Rect.fromLTWH(penaltyAreaLeft, 0, penaltyAreaWidth, penaltyAreaHeight),
      linePaint,
    );

    // Bottom penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        penaltyAreaLeft,
        size.height - penaltyAreaHeight,
        penaltyAreaWidth,
        penaltyAreaHeight,
      ),
      linePaint,
    );

    // Draw goal areas
    final double goalAreaWidth = size.width * 0.25;
    final double goalAreaHeight = size.height * 0.05;
    final double goalAreaLeft = (size.width - goalAreaWidth) / 2;

    // Top goal area
    canvas.drawRect(
      Rect.fromLTWH(goalAreaLeft, 0, goalAreaWidth, goalAreaHeight),
      linePaint,
    );

    // Bottom goal area
    canvas.drawRect(
      Rect.fromLTWH(
        goalAreaLeft,
        size.height - goalAreaHeight,
        goalAreaWidth,
        goalAreaHeight,
      ),
      linePaint,
    );

    // Draw penalty arcs
    final double penaltySpotDistance = size.height * 0.10;
    final double arcRadius = size.width * 0.15;

    // Top penalty arc
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, penaltySpotDistance),
        radius: arcRadius,
      ),
      0.6435, // ~36.87 degrees in radians
      1.8546, // ~106.26 degrees in radians
      false,
      linePaint,
    );

    // Bottom penalty arc
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height - penaltySpotDistance),
        radius: arcRadius,
      ),
      3.785, // ~216.87 degrees
      1.8546,
      false,
      linePaint,
    );

    // Draw corner arcs
    final double cornerRadius = size.width * 0.04;
    canvas.drawArc(
      Rect.fromCircle(center: const Offset(0, 0), radius: cornerRadius),
      0,
      1.5708, // 90 degrees
      false,
      linePaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, 0), radius: cornerRadius),
      1.5708,
      1.5708,
      false,
      linePaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height), radius: cornerRadius),
      4.7124,
      1.5708,
      false,
      linePaint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width, size.height),
        radius: cornerRadius,
      ),
      3.14159,
      1.5708,
      false,
      linePaint,
    );

    // Add vignette effect over everything
    final vignettePaint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.transparent,
          Colors.black.withValues(alpha: 0.4),
        ],
        stops: const [0.7, 1.0],
        radius: 0.8,
      ).createShader(rect);
    canvas.drawRect(rect, vignettePaint);
  }

  @override
  bool shouldRepaint(covariant PitchPainter oldDelegate) => 
      pitchColor != oldDelegate.pitchColor || lineColor != oldDelegate.lineColor;
}
