import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/config/color.dart';

class LineChartListener extends StatefulWidget {
  final List<num> yPoint;
  const LineChartListener({ Key? key, required this.yPoint }) : super(key: key);
  
  @override
  LineChartListenerState createState() => LineChartListenerState();
}
class LineChartListenerState extends State<LineChartListener> {
  final GlobalKey _paintKey = GlobalKey();
  Offset? _offset;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        RenderBox referenceBox = _paintKey.currentContext!.findRenderObject() as RenderBox;
        Offset offset = referenceBox.globalToLocal(event.position);
        setState(() {
          _offset = offset;
        });
      },
      child: CustomPaint(
        key: _paintKey,
        size: const Size(102, 50),
        painter: LineChartPaint(
          _offset,
          yPoint: widget.yPoint
        ),
      ),
    );
  }
}

class LineChartPaint extends CustomPainter {
  final List<num> yPoint;
  late num yMax, yMin, xMax, xMin, maxLimit, minLimit;
  Offset? clickOffset;

  LineChartPaint(this.clickOffset, {required this.yPoint}) {
    yMax = yPoint[0];
    yMin = yPoint[0];
    xMax = 0;
    xMin = 0;
    for (var i = 0; i < yPoint.length; i++) {
      var data = yPoint[i];
      if (data >= yMax) {
        xMax = i;
        yMax = data;
      } else if (data <= yMin) {
        xMin = i;
        yMin = data;
      }
    }
    maxLimit = yMax * 1.05;
    minLimit = yMin * 0.95;
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    final canvasHeight = size.height;
    final canvasWidth = size.width;
    final yUnit = canvasHeight / (maxLimit - minLimit);
    final xUnit = canvasWidth / yPoint.length;

    Paint backPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        const Offset (0, 5),
        Offset (0, canvasHeight),
        [
          const Color.fromARGB(153, 133, 171, 212),
          const Color.fromARGB(26, 133, 171, 212),
        ],
      );

    void drawLineLabel() {
      Offset p1 = const Offset(0, 0);
      Offset p2 = Offset(0, canvasHeight);
      canvas.drawLine(p1, p2, pathPaint(rootColor['canvasLine']!, 0.8));
    }

    void drawDataLine() {
      final path = Path();
      for (var i = 0; i < yPoint.length; i++) {
        var data = yPoint[i];
        if (i == 0) {
          path.moveTo(i.toDouble()*xUnit, (maxLimit - data.toDouble())*yUnit);
        } else {
          path.lineTo(i.toDouble()*xUnit, (maxLimit - data.toDouble())*yUnit);
        }
      }
      canvas.drawPath(path, pathPaint(rootColor['canvasLine']!, 0.8));

      path.lineTo(canvasWidth, canvasHeight);
      path.lineTo(0, canvasHeight);
      canvas.drawPath(path, backPaint);
    }

    void drawHeightLow() {
      ParagraphConstraints paragraphConstraints = ParagraphConstraints(width: size.width);

      ParagraphBuilder heightParagraphBuilder = ParagraphBuilder(ParagraphStyle());
      heightParagraphBuilder.pushStyle(
        ui.TextStyle(
          fontSize: 11,
          color: rootColor['canvasHeight']
        )
      );
      heightParagraphBuilder.addText(yMax.toString());
      Paragraph heightParagraph = heightParagraphBuilder.build() ..layout(paragraphConstraints);
      canvas.drawPoints(ui.PointMode.points, [Offset(xMax*xUnit, (maxLimit - yMax.toDouble())*yUnit)], pointPaint(rootColor['canvasHeight']!));
      canvas.drawParagraph(heightParagraph, Offset(xMax*xUnit+3, (maxLimit - yMax.toDouble())*yUnit-5));

      ParagraphBuilder lowParagraphBuilder = ParagraphBuilder(ParagraphStyle());
      lowParagraphBuilder.pushStyle(
        ui.TextStyle(
          fontSize: 11,
          color: rootColor['canvasLow']
        )
      );
      lowParagraphBuilder.addText(yMin.toString());
      Paragraph lowParagraph = lowParagraphBuilder.build() ..layout(paragraphConstraints);
      canvas.drawPoints(ui.PointMode.points, [Offset(xMin*xUnit, (maxLimit - yMin.toDouble())*yUnit)], pointPaint(rootColor['canvasLow']!));
      canvas.drawParagraph(lowParagraph, Offset(xMin*xUnit+3, (maxLimit - yMin.toDouble())*yUnit-5));
    }
    
    if (clickOffset != null) {
      final path = Path();
      var index = 0;
      var x = 150.0;
      for (var i = 0; i < yPoint.length; i++) {
        if (((clickOffset!.dx - (i*xUnit)).abs()) < x) {
          x = (clickOffset!.dx - (i*xUnit)).abs();
          index = i;
        }
      }
      
      path.moveTo(index * xUnit, 0);
      path.lineTo(index * xUnit, canvasHeight);

      ParagraphBuilder heightParagraphBuilder = ParagraphBuilder(ParagraphStyle());
      heightParagraphBuilder.pushStyle(
        ui.TextStyle(
          fontSize: 11,
          color: rootColor['canvasFocus']
        )
      );
      heightParagraphBuilder.addText(yPoint[index].toString());
      ParagraphConstraints paragraphConstraints = ParagraphConstraints(width: size.width);
      Paragraph paragraph = heightParagraphBuilder.build() ..layout(paragraphConstraints);

      canvas.drawPoints(ui.PointMode.points, [Offset(index * xUnit, (maxLimit - yPoint[index]) * yUnit)], pointPaint(rootColor['canvasFocus']!));
      canvas.drawPath(path, pathPaint(rootColor['canvasFocus']!, 0.7));
      canvas.drawParagraph(paragraph, Offset(index * xUnit+3, (maxLimit - yPoint[index].toDouble()) * yUnit-5));
    }

    drawLineLabel();
    drawDataLine();
    drawHeightLow();
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Paint pointPaint(Color color) {
  return Paint()
    ..color = color
    ..strokeWidth = 5.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
}

Paint pathPaint(Color color, double width) {
  return Paint()
    ..color = color
    ..strokeWidth = width
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
}