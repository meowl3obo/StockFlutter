import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class KStick extends StatelessWidget {
  final num closePrice;
  final num openPrice;
  final num high;
  final num low;
  const KStick({Key? key, required this.closePrice, required this.openPrice, required this.high, required this.low}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(16, 50),
      painter: KStickPaint(
          closePrice: closePrice,
          openPrice: openPrice,
          high: high,
          low: low,
      ),
    );
  }
}

class KStickPaint extends CustomPainter {
  final num closePrice;
  final num openPrice;
  final num high;
  final num low;
  late final Color stickColor;
  KStickPaint({required this.closePrice, required this.openPrice, required this.high, required this.low}) {
    stickColor = closePrice > openPrice ? rootColor['danger']! : closePrice < openPrice ? rootColor['success']! : rootColor['canvasFocus']!;
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    final canvasHeight = size.height;
    final canvasWidth = size.width;
    final yUnit = canvasHeight / (high - low);

    void drawCenterLine() {
      Paint paint = Paint()
        ..color = stickColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      var x = canvasWidth/2;

      canvas.drawLine(Offset(x, 0), Offset(x, canvasHeight), paint);
    }

    void drawContent() {
      Paint paint = Paint()
        ..color = stickColor
        ..style = PaintingStyle.fill;

      var y1 = (high - closePrice) * yUnit;
      var y2 = (high - openPrice) * yUnit;
      final path = Path();
      path.moveTo(0, y1);
      path.lineTo(canvasWidth, y1);
      path.lineTo(canvasWidth, y2);
      path.lineTo(0, y2);

        
      canvas.drawPath(path, paint);
    }

    void drawSameContent() {
      Paint paint = Paint()
        ..color = stickColor
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      var y = (high - closePrice) * yUnit;

      if (high == low) {
        canvas.drawLine(Offset(0, canvasHeight/2), Offset(canvasWidth, canvasHeight/2), paint);
      } else {
        canvas.drawLine(Offset(0, y), Offset(canvasWidth, y), paint);
      }
    }

    if (high != low) {
      drawCenterLine();
    }
    if (closePrice != openPrice) {
      drawContent();
    } else {
      drawSameContent();
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}