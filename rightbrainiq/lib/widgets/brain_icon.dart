import 'package:flutter/material.dart';

class BrainIcon extends StatelessWidget {
  final double size;
  final Color color;

  const BrainIcon({super.key, this.size = 60, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _BrainPainter(color: color),
      ),
    );
  }
}

class _BrainPainter extends CustomPainter {
  final Color color;

  _BrainPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    canvas.save();

    final leftPath = Path();
    leftPath.moveTo(cx - 2, h * 0.12);
    leftPath.cubicTo(cx * 0.52, h * 0.08, w * 0.06, h * 0.22, w * 0.08, h * 0.44);
    leftPath.cubicTo(w * 0.09, h * 0.52, w * 0.14, h * 0.58, w * 0.20, h * 0.62);
    leftPath.cubicTo(w * 0.14, h * 0.70, w * 0.14, h * 0.80, w * 0.22, h * 0.86);
    leftPath.cubicTo(w * 0.28, h * 0.90, w * 0.34, h * 0.90, w * 0.38, h * 0.88);
    leftPath.cubicTo(w * 0.40, h * 0.92, w * 0.44, h * 0.94, cx - 2, h * 0.94);
    leftPath.close();

    final rightPath = Path();
    rightPath.moveTo(cx + 2, h * 0.12);
    rightPath.cubicTo(w * 0.48, h * 0.08, w * 0.94, h * 0.22, w * 0.92, h * 0.44);
    rightPath.cubicTo(w * 0.91, h * 0.52, w * 0.86, h * 0.58, w * 0.80, h * 0.62);
    rightPath.cubicTo(w * 0.86, h * 0.70, w * 0.86, h * 0.80, w * 0.78, h * 0.86);
    rightPath.cubicTo(w * 0.72, h * 0.90, w * 0.66, h * 0.90, w * 0.62, h * 0.88);
    rightPath.cubicTo(w * 0.60, h * 0.92, w * 0.56, h * 0.94, cx + 2, h * 0.94);
    rightPath.close();

    canvas.drawPath(leftPath, paint);
    canvas.drawPath(rightPath, paint);

    final centerPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    final centerLine = Path()
      ..moveTo(cx, h * 0.10)
      ..cubicTo(cx - w * 0.02, h * 0.25, cx + w * 0.02, h * 0.40, cx, h * 0.55)
      ..cubicTo(cx - w * 0.02, h * 0.70, cx + w * 0.02, h * 0.85, cx, h * 0.94);

    canvas.drawPath(centerLine, centerPaint);

    final highlightPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    final leftHL = Path()
      ..moveTo(cx * 0.50, h * 0.28)
      ..cubicTo(cx * 0.30, h * 0.26, w * 0.18, h * 0.33, w * 0.20, h * 0.42)
      ..cubicTo(w * 0.22, h * 0.36, cx * 0.35, h * 0.32, cx * 0.50, h * 0.33)
      ..close();

    final rightHL = Path()
      ..moveTo(w - cx * 0.50, h * 0.28)
      ..cubicTo(w - cx * 0.30, h * 0.26, w * 0.82, h * 0.33, w * 0.80, h * 0.42)
      ..cubicTo(w * 0.78, h * 0.36, w - cx * 0.35, h * 0.32, w - cx * 0.50, h * 0.33)
      ..close();

    canvas.drawPath(leftHL, highlightPaint);
    canvas.drawPath(rightHL, highlightPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BrainPainter oldDelegate) => oldDelegate.color != color;
}
