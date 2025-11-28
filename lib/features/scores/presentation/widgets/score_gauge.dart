import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScoreGauge extends StatelessWidget {
  final int score;
  final Color color;

  const ScoreGauge({super.key, required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    final progress = score.clamp(0, 100) / 100;
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.16),
            blurRadius: 12,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _GaugePainter(
          progress: progress,
          color: color,
          background: CupertinoTheme.of(context).primaryContrastingColor,
        ),
        child: SizedBox(
          height: 140,
          width: 140,
          child: Center(
            child: Text(
              '$score',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color background;

  _GaugePainter({
    required this.progress,
    required this.color,
    required this.background,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 16;

    final bgPaint =
        Paint()
          ..color = background.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;

    final fgPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      fgPaint,
    );

    // dotted field
    const ringOffsets = [30.0, 60.0, 100.0];
    const dotCounts = [25, 30, 35];
    const ringOpacities = [0.3, 0.22, 0.14];
    for (var ringIndex = 0; ringIndex < ringOffsets.length; ringIndex++) {
      final dotPaint =
          Paint()
            ..color = background.withValues(alpha: ringOpacities[ringIndex])
            ..style = PaintingStyle.fill;
      final ringRadius = radius + ringOffsets[ringIndex];
      final dotsInRing = dotCounts[ringIndex];
      for (var i = 0; i < dotsInRing; i++) {
        final angle = 2 * math.pi * (i / dotsInRing);
        final dx = center.dx + ringRadius * math.cos(angle);
        final dy = center.dy + ringRadius * math.sin(angle);
        canvas.drawCircle(Offset(dx, dy), 3.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
