import 'package:flutter/material.dart';
import 'package:genclikduragiqr/sabitler/const.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 175,
      child: CustomPaint(
        painter: MyPainter(),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double r = 20; //<-- corner radius

    Paint blackPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    Paint redPaint = Paint()
      ..color = blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path topRightArc = Path()
      ..moveTo(w - r, 0)
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r));
    Path topLeftArc = Path()
      ..moveTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r), clockwise: true);
    Path bottomLeftArc = Path()
      ..moveTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r));

    Path bottomRightArc = Path()
      ..moveTo(w - r, h)
      ..arcToPoint(Offset(w, h - r),
          radius: Radius.circular(r), clockwise: false);
    canvas.drawRRect(fullRect, blackPaint);
    canvas.drawPath(topRightArc, redPaint);
    canvas.drawPath(topLeftArc, redPaint);

    canvas.drawPath(bottomLeftArc, redPaint);
    canvas.drawPath(bottomRightArc, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
