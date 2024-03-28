import 'package:flutter/material.dart';

class FolderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(86.351, 17.027);
    path_0.lineTo(35.525, 17.027);
    path_0.cubicTo(33.616, 17.027, 31.819, 16.124000000000002, 30.679, 14.592);
    path_0.lineTo(28.221999999999998, 11.290000000000001);
    path_0.cubicTo(27.409999999999997, 10.198, 26.128999999999998,
        9.555000000000001, 24.767999999999997, 9.555000000000001);
    path_0.lineTo(3.649, 9.555000000000001);
    path_0.cubicTo(1.634, 9.556, 0, 11.19, 0, 13.205);
    path_0.lineTo(0, 29.11);
    path_0.lineTo(0, 76.795);
    path_0.cubicTo(0, 78.81, 1.634, 80.444, 3.649, 80.444);
    path_0.lineTo(86.352, 80.444);
    path_0.cubicTo(88.367, 80.444, 90.001, 78.81, 90.001, 76.795);
    path_0.lineTo(90.001, 29.11);
    path_0.lineTo(90.001, 20.674999999999997);
    path_0.cubicTo(90, 18.661, 88.366, 17.027, 86.351, 17.027);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint0Stroke.color = const Color(0xff1b3e96);
    paint0Stroke.strokeCap = StrokeCap.round;
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff1b3e96);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
